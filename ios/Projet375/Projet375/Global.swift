//
//  Global.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

func getImage(url: String, completitionHandler: (_ success: Bool, _ imageDownloaded: UIImage?) -> Void) {
    
    //  Download the image
    let imageData = NSData(contentsOf: NSURL(string: url)! as URL)
    
    if(imageData != nil) {
        let image = UIImage(data: NSData(data: imageData! as Data) as Data)
        completitionHandler(true, image)
    }
        
    else {
        completitionHandler(false, nil)
    }
}


//  Return the image size with the good ratio
func imageSize(imageWidth: CGFloat, imageSize: CGSize) -> (width: CGFloat, height: CGFloat) {
    let ratio = imageSize.width / imageSize.height
    return (imageWidth, imageWidth / ratio)
}

//  Return the image size with the good ratio
func imageSizeHeight(imageHeight: CGFloat, imageSize: CGSize) -> (width: CGFloat, height: CGFloat) {
    let ratio = imageSize.height / imageHeight
    return (imageSize.width / ratio, imageHeight)
}

//  Display an alert view
func displayAlert(currentViewController: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    currentViewController.present(alert, animated: true, completion: nil)
}

func resetUser() {
    let userDefault = UserDefaults.standard
    userDefault.set(nil, forKey: "facebook_id")
    userDefault.set(nil, forKey: "first_name")
    userDefault.set(nil, forKey: "last_name")
    userDefault.set(nil, forKey: "url_image")
    userDefault.set(nil, forKey: "token")
    userDefault.synchronize()
}

func getUserInfo() {
    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "email, name, first_name, last_name, picture.type(large)"]).start { (requestConn: FBSDKGraphRequestConnection?, userInfo: Any?, error: Error?) in
        
        if(error == nil) {
            let userInfoObject = userInfo as AnyObject
            print(userInfoObject)
            let id = userInfoObject["id"] as? String
            let firstName = userInfoObject["first_name"] as? String
            let lastName = userInfoObject["last_name"] as? String
            let imageUrl = ((userInfoObject["picture"] as? AnyObject)!["data"] as? AnyObject)!["url"]
            
            if(id != nil && firstName != nil && lastName != nil && imageUrl != nil) {
                let userDefault = UserDefaults.standard
                userDefault.set(id, forKey: "facebook_id")
                userDefault.set(firstName!, forKey: "first_name")
                userDefault.set(lastName!, forKey: "last_name")
                userDefault.set(imageUrl!!, forKey: "url_image")
                userDefault.synchronize()
            }
        }
            
        else {
            print(error)
            resetUser()
        }
        
    }
}

