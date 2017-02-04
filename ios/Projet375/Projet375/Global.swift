//
//  Global.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

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

