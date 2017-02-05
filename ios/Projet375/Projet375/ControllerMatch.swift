//
//  ControllerMatch.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class ControllerMatch: Controller {
    
    static func getMatch(completitionHandler: @escaping (_ success: Bool, _ match: Match?) -> Void) {
        
        getData(url: "\(kBaseUrl)/get_match.php", postParameterAsString: "facebook_id=\(kCurrentUser.fbId)") { (success, jsonResult) in
            
            if(success && jsonResult != nil) {
                
                if let json = jsonResult!["values"] as? AnyObject {
                    print(json)
                    //  If there's a description, new match
                    if let desc = json["description"] as? String {
                        let m = Match()
                        m.state = kNewMatch
                        
                        completitionHandler(true, m)
                    }
                        
                    else {
                        print(kCurrentUser.fbId)
                        let opposantId = json["facebook_id"] as? String
                        let score = json["score"] as? String
                        let firstName = json["first_name"] as? String
                        let lastName = json["last_name"] as? String
                        let token = json["token"] as? String
                        
                        if opposantId != nil && score != nil && firstName != nil && lastName != nil && token != nil {
                            
                            if(opposantId! == kCurrentUser.fbId) {
                                let m = Match()
                                m.state = kNewMatch
                                
                                completitionHandler(true, m)
                                
                            }
                                
                            else {
                                
                                let m = Match()
                                m.opposantPlayerId = opposantId!
                                m.score = Int(score!)!
                                m.firstName = firstName!
                                m.lastName = lastName!
                                m.opposantToken = token!
                                m.state = kOldMatch
                                completitionHandler(true, m)
                            }
                        }
                        
                    }
                }
            }
                
            else {
                completitionHandler(false, nil)
            }
        }
    }
    
    static func setMatch(playerId: String, score: Int, completitionHandler: @escaping (_ success: Bool) -> Void) {
        
        getData(url: "\(kBaseUrl)/set_match.php", postParameterAsString: "facebook_id=\(playerId)&score=\(score)") { (success, jsonResult) in
            
            completitionHandler(success)
        }
    }
    
    //  Game qui existe déja
    static func setScore(playerId: String, score: Int, token: String, completitionHandler: @escaping (_ success: Bool) -> Void) {
        
        getData(url: "\(kBaseUrl)/set_score.php", postParameterAsString: "facebook_id=\(playerId)&point=\(score)&token=\(token)") { (success, jsonResult) in
            
            completitionHandler(success)
        }
    }
}
