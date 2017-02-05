//
//  questionView.swift
//  Projet375
//
//  Created by Alex Morin on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import MapKit

class questionView: UIView {
    
    var navBar: UINavigationBar
    var image: UIImageView
    var questionLabel: UILabel
    let margin:CGFloat = 10
    var buttons: [UIButton]
    var que = question(id: -1, type: -1, categorie: "", quest: "", reponse: ["","","",""], reponseImage: [UIImage()], imageQuestion: UIImage(), reponseId: -1, location: CLLocationCoordinate2D())
    
    override init(frame: CGRect) {
        navBar = UINavigationBar()
        image = UIImageView()
        questionLabel = UILabel()
        buttons = []
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, q: question) {
        navBar = UINavigationBar()
        image = UIImageView()
        questionLabel = UILabel()
        buttons = []
        que = q
        super.init(frame:frame)
        createHeader(cat: que.categorie)
        
        
        switch que.type {
        case kTypeMap:
            //On load la view map
            createMapContent()
        case kTypePicture:
            //On load la view image
            createPictureContent()
        case kTypeRegular:
            //On load la view reguliere question réponse
            createRegularContent()
        default:
            //On fait rien...
            print("Does not work...")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHeader(cat: String) {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight*0.1))
        navBar.barStyle = UIBarStyle.default
        navBar.barTintColor = kColorForCategories[cat]
        
        let navItem = UINavigationItem(title: cat);
        navBar.setItems([navItem], animated: false);
        
        self.addSubview(navBar)
    }
    
    func createRegularContent() {
        
        if(que.imageQuestion?.cgImage == nil) {
            image = UIImageView(frame: CGRect(x: margin/2, y: navBar.frame.maxY + margin/2, width: self.frame.width-margin, height: self.frame.height*0.4))
            image.backgroundColor = UIColor.brown
            image.layer.cornerRadius = 20
            //image.image = que.imageQuestion!
            questionLabel = UILabel(frame: CGRect(x: margin/2, y: image.frame.maxY + margin/2, width: self.frame.width-margin, height: self.frame.height*0.1))
            image.clipsToBounds = true
        } else {
            image = UIImageView(frame: CGRect(x: margin/2, y: navBar.frame.maxY + margin/2, width: 0, height: 0))
            questionLabel = UILabel(frame: CGRect(x: margin/2, y: image.frame.maxY, width: self.frame.width-margin, height: self.frame.height*0.5))
            questionLabel.font = UIFont(name: questionLabel.font.fontName, size: 25)
        }
        
        
        questionLabel.text = que.quest
        questionLabel.backgroundColor = UIColor.purple
        questionLabel.numberOfLines = 3
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.layer.cornerRadius = 20
        questionLabel.clipsToBounds = true
        
        let buttonHeight = (self.frame.height - self.questionLabel.maxY-(5*margin)/2)/4
        
        for index in 0...3 {
            let button = UIButton(frame: CGRect(x: margin/2, y: questionLabel.frame.maxY + (CGFloat(index)*buttonHeight) + margin/2 + margin/2*CGFloat(index), width: self.frame.width - margin, height: buttonHeight))
            button.setTitleColor(UIColor.black, for: [])
            button.setTitle(que.reponse![index], for: [])
            
            button.layer.borderWidth = 4
            button.layer.borderColor = (UIColor.black).cgColor
            button.layer.cornerRadius = 20
            button.tag = index
            button.addTarget(self, action: #selector(checkAnswer(sender:)), for: UIControlEvents.touchUpInside)
            button.clipsToBounds = true
            buttons.append(button)
            self.addSubview(buttons[index])
        }
        self.addSubview(image)
        self.addSubview(questionLabel)
    }
    
    func checkAnswer(sender: UIButton) {
        if(sender.tag == que.reponseId) {
            sender.layer.borderWidth = 4
            sender.layer.borderColor = (UIColor.green).cgColor
            sender.layer.cornerRadius = 20
        } else {
            sender.layer.borderWidth = 4
            sender.layer.borderColor = (UIColor.red).cgColor
            sender.layer.cornerRadius = 20
        }
    }
    
    
    
    
    
    
    
    func createMapContent() {
        
    }
    
    func createPictureContent() {
        
    }
    
    

}
