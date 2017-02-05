//
//  ControllerArena.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-05.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class ControllerArena: Controller {
    static func getArena(completitionHandler: @escaping (_ success: Bool, _ arena: Arena?) -> Void) {
        
        getData(url: "\(kBaseUrl)/get_arena.php", postParameterAsString: nil) { (success, jsonResult) in
            
            if(success && jsonResult != nil) {
                
                var usercharts = [UserChart]()
                if let values = jsonResult!["values"] as? AnyObject {
                    print(values)
                    
                    let id = values["id"] as! String
                    let name = "Polytechnique de montréal"
                    let winnerId = values["facebook_id"] as! String
                    let nbQuestionReussi = values["nombre_question"] as! String
                    let lat = values["lat"] as! String
                    let lng = values["lng"] as! String
                    let point = values["point"] as! String
                    let urlImage = values["url_image"] as! String
                    let firstName = values["first_name"] as! String
                    let lastName = values["last_name"] as! String
                    let token = values["token"] as! String
                    
                    let a = Arena()
                    a.id = Int(id)
                    a.name = name
                    a.nbQuestionReussi = Int(nbQuestionReussi)
                    a.lat = Double(lat)
                    a.long = Double(lng)
                    a.point = Int(point)
                    
                    let winner = User()
                    winner.firstName = firstName
                    winner.lastName = lastName
                    winner.fbId = winnerId
                    winner.profileImageUrl = urlImage
                    winner.token = token
                    
                    a.winner = winner
                    
                    completitionHandler(true, a)
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
    
    static func setArena(arenaId: Int, nbQuestionReussi: Int, completitionHandler: @escaping (_ success: Bool) -> Void) {
        
        getData(url: "\(kBaseUrl)/get_arena.php", postParameterAsString: "arenaId=\(arenaId)&nombre_question\(nbQuestionReussi)&facebook_id\(kCurrentUser.fbId)") { (success, jsonResult) in
            
            completitionHandler(success)
        }
    }
}
