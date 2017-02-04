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
