//
//  ControllerQuestion.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import CoreLocation

class ControllerQuestion: Controller {
    //  Return the user id of a user
    static func getQuestion(location: CLLocationCoordinate2D?, cat: Int, completitionHandler: @escaping (_ success: Bool, _ question: question?) -> Void) {
        
        let long: Double = location == nil ? 0 : (location?.longitude)!
        let lat: Double = location == nil ? 0 : (location?.latitude)!
        let postString = "lat=\(lat)&lng=\(long)&cat=\(cat)"
        
        getData(url: "\(kBaseUrl)/question.php", postParameterAsString: postString) { (success, jsonResult) in
        
            if(success) {
                let json = jsonResult!["values"] as? AnyObject
                
                if let json = json {
                    let id = json["id"] as? String
                    let typeId = json["type_id"] as? String
                    let cat = json["cat"] as? String
                    let questionStr = json["question"] as? String
                    let a1 = json["response_1"] as? String
                    let a2 = json["response_2"] as? String
                    let a3 = json["response_3"] as? String
                    let a4 = json["response_4"] as? String
                    let responseId = json["response_id"] as? String
                    
                    if typeId != nil && Int(typeId!)! == 0 && id != nil && typeId != nil && cat != nil && questionStr != nil && a1 != nil && a2 != nil && a3 != nil && responseId != nil {
                        
                        
                        let q = question(id: Int(id!)!, type: Int(typeId!)!, categorie: cat!, quest: questionStr!, reponse: [a1!, a2!, a3!, a4!], reponseImage: [UIImage(named: "guy_icon")!], reponseId: Int(responseId!)!, location: CLLocationCoordinate2D(latitude: 0, longitude: 0))
                        
                        completitionHandler(true, q)
                    }
                    
                        //  Map
                    else if (typeId != nil && Int(typeId!)! == 1) {
                        if(id != nil && typeId != nil && cat != nil && questionStr != nil) {
                            
                            let latR = json["lat"] as? String
                            let longR = json["lng"] as? String
                            
                            if(latR != nil && longR != nil) {
                                let q = question(id: Int(id!)!, type: Int(typeId!)!, categorie: cat!, quest: questionStr!, reponse: [], reponseImage: [UIImage(named: "guy_icon")!], reponseId: -1, location: CLLocationCoordinate2D(latitude: Double(latR!)!, longitude: Double(longR!)!))
                                
                                completitionHandler(true, q)
                            }
                            
                            else {
                                completitionHandler(false, nil)
                            }
                        }
                        
                        else {
                            completitionHandler(false, nil)
                        }
                    }
                }
                
            }
            
            else {
                completitionHandler(false, nil)
            }
            
        }
    }
}
