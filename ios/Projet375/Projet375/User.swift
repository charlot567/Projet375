//
//  User.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class User {
    
    var fbId: String!
    var firstName: String!
    var lastName: String!
    var profileImageUrl: String!
    var token: String!
    
    private var _profileImage: UIImage!
    
    private var _completeName: String!
    var completeName: String {
        
        get {
            if let completeName = _completeName {
                return completeName
            }
            
            _completeName = "\(firstName!) \(lastName!)"
            return _completeName
        }
        
        set {
            _completeName = newValue
        }
    }
    
    func getProfileImage(completitionHandler: (_ imageDownloaded: UIImage?) -> Void) {
        if _profileImage != nil {
            return completitionHandler(_profileImage)
        }
        
        if let url = profileImageUrl {
            getImage(url: url, completitionHandler: { (success: Bool, image: UIImage?) in
                
                if(success && image != nil) {
                    _profileImage = image!
                    
                    return completitionHandler(_profileImage)
                }
            })
            
        }
        
        _profileImage = UIImage(named: "default_profile_image")
        
        return completitionHandler(_profileImage)
    }
}
