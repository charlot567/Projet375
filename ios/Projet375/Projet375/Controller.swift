//
//  Controller.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import Foundation

public class Controller {
    
    static func getData(url: String, postParameterAsString: String?, completitionHandler: @escaping (_ success: Bool, _ jsonResult: AnyObject?) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        //  Add the app key to the post string
        let postString = postParameterAsString == nil ? "" : "\(postParameterAsString!)"
        
        //  Build the request
        request.httpBody = postString.data(using: String.Encoding.utf8)
    
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            //  Check for error
            guard error == nil && data != nil else {
                print("error=\(error)")
                completitionHandler(false, nil)
                return
            }
            
            //  If we get a 200 status code
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                
                //  Get the response
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject]
                    print(json)
                    //  If the request work
                    if(json!["status"] as! String == "1" || json!["status"] as! String == "0") {
                        completitionHandler(true, json as AnyObject?)
                    }
                        
                    else {
                        
                        completitionHandler(false, nil)
                    }
                    
                } catch {
                    completitionHandler(false, nil)
                }
            }
                
            else {
                
                //  Get the status code
                if let httpStatus = response as? HTTPURLResponse {
                    let code = httpStatus.statusCode
                    completitionHandler(false, nil)
                    
                }
                    
                    //  If we can't get the status code
                else {
                    completitionHandler(false, nil)
                }
            }
        }
        task.resume()
    }
}
