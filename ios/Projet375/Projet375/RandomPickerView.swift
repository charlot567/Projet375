//
//  RandomPickerView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import SwiftSpinner

class RandomPickerView: UIView {
    
    
    //  Géo
    //  Histoire
    //  Tourisme
    //  Art
    
    var questionView: QuestionView!
    private var categoryView = [UIButton]()
    private var currentCat: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
        let viewWidth = kWidth / 1.5
        
        let geoView = UIButton()
        geoView.frame = CGRect(x: kWidth / 2 - viewWidth / 2, y: kHeight / 2 - viewWidth / 2, width: viewWidth, height: viewWidth)
        geoView.backgroundColor = kColorForCategories[kCat1]
        geoView.tag = 0
        geoView.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        
        let geoImage = UIImage(named: "geo_icon")
        let geoSize = imageSize(imageWidth: geoView.w * 0.7, imageSize: geoImage!.size)
        
        let geoImg = UIButton()
        geoImg.frame = CGRect(x: geoView.w / 2 - geoSize.width / 2, y: geoView.h / 2 - geoSize.height / 2, width: geoSize.width, height: geoSize.height)
        geoImg.setImage(geoImage, for: .normal)
        geoImg.tag = 0
        geoImg.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        geoView.addSubview(geoImg)
        categoryView.append(geoView)
        
        let historyView = UIButton()
        historyView.frame = CGRect(x: kWidth / 2 - viewWidth / 2, y: kHeight / 2 - viewWidth / 2, width: viewWidth, height: viewWidth)
        historyView.backgroundColor = kColorForCategories[kCat2]
        historyView.tag = 1
        historyView.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        
        let hImage = UIImage(named: "history_icon")
        let hSize = imageSize(imageWidth: historyView.w * 0.7, imageSize: hImage!.size)
        
        let hImg = UIButton()
        hImg.frame = CGRect(x: historyView.w / 2 - geoSize.width / 2, y: historyView.h / 2 - geoSize.height / 2, width: hSize.width, height: hSize.height)
        hImg.setImage(hImage, for: .normal)
        hImg.tag = 1
        hImg.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        historyView.addSubview(hImg)
        categoryView.append(historyView)
        
        let guyView = UIButton()
        guyView.frame = CGRect(x: kWidth / 2 - viewWidth / 2, y: kHeight / 2 - viewWidth / 2, width: viewWidth, height: viewWidth)
        guyView.backgroundColor = kColorForCategories[kCat3]
        guyView.tag = 2
        guyView.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        
        let gImage = UIImage(named: "guy_icon")
        let gSize = imageSize(imageWidth: guyView.w * 0.7, imageSize: gImage!.size)
        
        let gImg = UIButton()
        gImg.frame = CGRect(x: guyView.w / 2 - gSize.width / 2, y: guyView.h / 2 - geoSize.height / 2, width: gSize.width, height: gSize.height)
        gImg.setImage(gImage, for: .normal)
        gImg.tag = 2
        gImg.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        guyView.addSubview(gImg)
        categoryView.append(guyView)
        
        let artView = UIButton()
        artView.frame = CGRect(x: kWidth / 2 - viewWidth / 2, y: kHeight / 2 - viewWidth / 2, width: viewWidth, height: viewWidth)
        artView.backgroundColor = kColorForCategories[kCat4]
        artView.tag = 3
        artView.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        
        let aImage = UIImage(named: "art_icon")
        let aSize = imageSize(imageWidth: artView.w * 0.7, imageSize: aImage!.size)
        
        let aImg = UIButton()
        aImg.frame = CGRect(x: guyView.w / 2 - aSize.width / 2, y: artView.h / 2 - aSize.height / 2, width: aSize.width, height: aSize.height)
        aImg.setImage(aImage, for: .normal)
        aImg.tag = 3
        aImg.addTarget(self, action: #selector(clickToPlay(button:)), for: .touchUpInside)
        artView.addSubview(aImg)
        categoryView.append(artView)
    
    }
    
    func generateCategory() {
        let randomNum:UInt32 = arc4random_uniform(4)
        self.currentCat = Int(randomNum)
        self.addSubview(self.categoryView[Int(self.currentCat)])
    }
    
    func clickToPlay(button: UIButton) {
        
        SwiftSpinner.show("Récupération de la question ...")
        let tag = button.tag
        print("Play: \(tag)")
        
        
        ControllerQuestion.getQuestion(location: nil, cat: button.tag/**toreplace with button.tag*/) { (success: Bool, q: question?) in
            
            
            if(success && q != nil) {
                print("Question récupéré")
                
                DispatchQueue.main.sync {
                    self.questionView = QuestionView(frame: self.frame, q: q!)
                    self.questionView.layer.zPosition = 101
                    self.addSubview(self.questionView)
                    
                    SwiftSpinner.hide()
                }
            }
                
            else {
                displayAlert(currentViewController: kMasterVC, title: "Erreur", message: "Erreur lors de la récupération de la question")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
