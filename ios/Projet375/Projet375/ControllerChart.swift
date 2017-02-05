//
//  ControllerChart.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-05.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class ControllerChart: Controller {
    
    static func getChart(completitionHandler: @escaping (_ success: Bool, _ myScore: Int, _ users: [UserChart]?) -> Void) {
        
        getData(url: "\(kBaseUrl)/classement.php", postParameterAsString: "facebook_id=\(kCurrentUser.fbId)") { (success, jsonResult) in
            
            if(success && jsonResult != nil) {
                
                var usercharts = [UserChart]()
                if let values = jsonResult!["values"] as? AnyObject {
                 
                    for i in 0 ..< values.count {
                        let firstName = (values[i] as AnyObject)["first_name"] as? String
                        let lastName = (values[i] as AnyObject)["last_name"] as? String
                        let point = (values[i] as AnyObject)["point"] as? String
                        let imageUrl = (values[i] as AnyObject)["url_image"] as? String
                        
                        if firstName != nil && lastName != nil && point != nil && imageUrl != nil {
                            
                            let userChart = UserChart()
                            userChart.playerCompleteName = "\(firstName!) \(lastName!)"
                            userChart.point = Int(point!)!
                            userChart.urlImage = imageUrl!
                            
                            usercharts.append(userChart)
                        }
                    }
                    
                    completitionHandler(true, -1, usercharts)
                }
                
                else {
                    completitionHandler(false, -1, nil)
                }
          
            }
            
            else {
                
            }
        }
    }
}
