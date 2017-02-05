//
//  Extensions.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//


import UIKit


//  Extensions for the UILabel class
extension UILabel {
    
    //  Add the text with some spacing between the letters
    var textWithLetterSpacing: (String, CGFloat) {
        
        //  Return the text and 0 as spacing
        get {
            return (self.text == nil ? "" : self.text!, 0)
        }
        
        //  Set the text + the letter spacing
        set {
            
            //  Set the text
            self.text = newValue.0
            
            //  Add the space between the letter
            let attributedString = self.attributedText as! NSMutableAttributedString
            attributedString.addAttribute(NSKernAttributeName, value: newValue.1, range: NSMakeRange(0, attributedString.length))
            self.attributedText = attributedString
        }
    }
}

//  Extensions for the UITextView class
extension UITextView {
    
    //  Add the text with some spacing between the letters
    var textWithLetterSpacing: (String, CGFloat) {
        
        //  Return the text and 0 as spacing
        get {
            return (self.text == nil ? "" : self.text!, 0)
        }
        
        //  Set the text + the letter spacing
        set {
            
            //  Set the text
            self.text = newValue.0
            
            //            //  Add the space between the letter
            //            let attributedString = self.attributedText as! NSMutableAttributedString
            //            attributedString.addAttribute(NSKernAttributeName, value: newValue.1, range: NSMakeRange(0, attributedString.length))
            //            self.attributedText = attributedString
        }
    }
    
    //  Line spacing of the text view
    var lineSpacing: CGFloat {
        
        //  Return 0
        get {
            return 0
        }
        
        //  Set the letter spacing
        set {
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = newValue
            self.attributedText = NSAttributedString(string: self.text, attributes: [NSParagraphStyleAttributeName: style])
            
        }
    }
}

//  Extension of the uiview class
extension UIView {
    
    //  Return the max x position
    var maxX: CGFloat {
        
        get { return self.frame.maxX }
    }
    
    //  Return the max y position
    var maxY: CGFloat {
        
        get { return self.frame.maxY }
    }
    
    //  Return the min x position
    var minX: CGFloat {
        
        get { return self.frame.minX }
    }
    
    //  Return the min y position
    var minY: CGFloat {
        
        get { return self.frame.minY }
    }
    
    //  Return the width and set the width
    var w: CGFloat {
        
        set { self.frame = CGRect(x: self.x, y: self.y, width: newValue, height: self.h)}
        get { return self.frame.width }
    }
    
    //  Return the height and set the height
    var h: CGFloat {
        
        set { self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: newValue)}
        get { return self.frame.height }
    }
    
    //  Return the original x position and set the x position
    var x: CGFloat {
        
        set { self.frame = CGRect(x: newValue, y: self.y, width: self.w, height: self.h)}
        get { return self.frame.origin.x }
    }
    
    //  Return the original y position and set the y position
    var y: CGFloat {
        
        set { self.frame = CGRect(x: self.x, y: newValue, width: self.w, height: self.h)}
        get { return self.frame.origin.y }
    }
    
}

//  Extension of the uibutton class
extension UIButton {
    
    //  Increase button hitbox
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let t = UIEdgeInsetsMake(-20, -20, -20, -20)
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, t)
        return hitFrame.contains(point)
        
    }
}

//  Extension of the ui text field class
extension String {
    
    //  Return the nb of character
    func charactersCount() -> Int {
        if(self.isEmpty) { return 0 }
        if(self.characters.count == 0) { return 0 }
        return self.characters.count
    }
    
    //  Return the char at
    func charAt(index: Int) -> String {
        let s = self
        
        let c = s.characters;
        let r = c.index(c.startIndex, offsetBy: index)..<c.index(c.endIndex, offsetBy: (self.charactersCount() - index - 1) * -1)
        
        // Access the string by the range.
        let substring = s[r]
        return substring
    }
    
    //  Remove a character from string
    func removeChar(character: String) -> String {
        return self.replacingOccurrences(of: "\(character)", with: "", options: NSString.CompareOptions.literal, range: nil)
    }
    
    //  Return the index of a character
    func indefOf(from: Int, char: String) -> Int {
        for i in from ..< self.charactersCount() {
            
            if(self.charAt(index: i) == char) {
                return i
            }
        }
        
        return -1
    }
    
    func lz() -> String {
        let user = UserDefaults.standard
        let userLang = user.value(forKey: "appLanguage") as? String
        
        //  Get the good language
        let pre = userLang == nil ? NSLocale.preferredLanguages[0] : userLang!
        
        //  Default set to en
        var lang = "fr-CA"
        
        if(pre.uppercased().contains("FR")) {
            lang = "en"
        }
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}


