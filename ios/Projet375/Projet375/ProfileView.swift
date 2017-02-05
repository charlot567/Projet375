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
    private var profileImageView: UIImageView!
    private var usernamelabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        topNavBar = UIView()
        topNavBar.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight * 0.1)
        topNavBar.backgroundColor = kBlue
        self.addSubview(topNavBar)
        
        var gap = kWidth / 20
        var textHeight = topNavBar.h * 0.3
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
        
        let profileImageWidth = kWidth / 3
        profileImageView = UIImageView()
        profileImageView.frame = CGRect(x: kWidth / 2 - profileImageWidth / 2, y: topNavBar.maxY + profileImageWidth / 2, width: profileImageWidth, height: profileImageWidth)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageWidth / 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1
        self.addSubview(profileImageView)
        
        textHeight = kHeight / 20
        gap = kWidth / 20
        usernamelabel = UILabel()
        usernamelabel.frame = CGRect(x: gap, y: profileImageView.maxY + gap, width: kWidth - gap * 2, height: textHeight)
        usernamelabel.font = UIFont(name: "Helvetica", size: textHeight * 0.8)
        usernamelabel.textColor = UIColor.white
        usernamelabel.textAlignment = .center
        self.addSubview(usernamelabel)
        
    }
    
    func back() {
        print("back")
        kMasterVC.switchNav(index: KVHome)
    }
    
    func showPage() {
        
        usernamelabel.text = "\(kCurrentUser.completeName)"
        
        kCurrentUser.getProfileImage { (image: UIImage?) in
            if(image != nil) {
                
            
                    self.profileImageView.image = image
                
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
