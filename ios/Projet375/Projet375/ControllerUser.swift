//
//  ControllerUser.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

public class ControllerUser: Controller {
    
    //  Return the user id of a user
    static func signup(user: User, completitionHandler: @escaping (_ success: Bool) -> Void) {
        print(user.profileImageUrl!)
        
        var imageUrl = user.profileImageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        imageUrl = imageUrl.replacingOccurrences(of: "&", with: "%26")
        
        let postString = "facebook_id=\(user.fbId!)&first_name=\(user.firstName!)&last_name=\(user.lastName!)&url_image=\(imageUrl)&token=\(user.notificationToken == nil ? "NOTOKEN" : user.notificationToken!)"
        
        getData(url: "\(kBaseUrl)/user.php", postParameterAsString: postString) { (success, jsonResult) in
            
            let userDefault = UserDefaults.standard
            userDefault.set(user.fbId, forKey: "facebook_id")
            userDefault.set(user.firstName, forKey: "first_name")
            userDefault.set(user.lastName, forKey: "last_name")
            userDefault.set(user.profileImageUrl, forKey: "url_image")
            userDefault.set(user.notificationToken == nil ? "" : user.notificationToken, forKey: "token")
            userDefault.synchronize()
            
            completitionHandler(success)
        }
    }
}
