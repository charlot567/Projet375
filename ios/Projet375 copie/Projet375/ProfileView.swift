//
//  ProfileView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-05.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    private var topNavBar: UIView!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        topNavBar = UIView()
        topNavBar.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight * 0.1)
        topNavBar.backgroundColor = kBlue
        self.addSubview(topNavBar)
        
        let gap = kWidth / 20
        let textHeight = topNavBar.h * 0.3
        let fontSize = textHeight
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: gap, y: topNavBar.h / 2 - textHeight / 2 + textHeight * 0.3, width: kWidth - gap * 2, height: textHeight)
        titleLabel.font = UIFont(name: "Helvetica", size: fontSize)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = "Profil"
        titleLabel.adjustsFontSizeToFitWidth = true
        self.topNavBar.addSubview(titleLabel)
        
        let backImage = UIImage(named: "back_icon")
        let backSize = imageSize(imageWidth: kWidth / 20, imageSize: backImage!.size)
        let backButton = UIButton()
        backButton.frame = CGRect(x: backSize.width * 0.5, y: topNavBar.h / 2 - backSize.height / 2, width: backSize.width, height: backSize.height)
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.topNavBar.addSubview(backButton)
        
        self.backgroundColor = kGreen
        
//        
//        let profileImageWidth = kWidth / 6
//        let profileImageView = UIImageView()
//        profileImageView.frame = cgrect
    }
    
    func back() {
        print("back")
        kMasterVC.switchNav(index: KVHome)
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
