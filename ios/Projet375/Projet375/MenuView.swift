//
//  MenuView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    private var topNavBar: UIView!
    private var usernameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        topNavBar = UIView()
        topNavBar.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight * 0.1)
        topNavBar.backgroundColor = kBlue
        self.addSubview(topNavBar)
        
        let gap = kWidth / 20
        let textHeight = topNavBar.h * 0.3
        let fontSize = textHeight
        usernameLabel = UILabel()
        usernameLabel.frame = CGRect(x: gap, y: topNavBar.h / 2 - textHeight / 2 + textHeight * 0.3, width: kWidth - gap * 2, height: textHeight)
        usernameLabel.font = UIFont(name: "Helvetica", size: fontSize)
        usernameLabel.textAlignment = .center
        usernameLabel.textColor = .white
        usernameLabel.adjustsFontSizeToFitWidth = true
        self.topNavBar.addSubview(usernameLabel)
        
        let buttonGapH: CGFloat = 2
        let buttonGapW: CGFloat = 2
        let buttonHeight = ((kHeight - topNavBar.h) - CGFloat(buttonGapH * 4)) / 3
        let imageSizeHeightForIcon = buttonHeight * 0.4
        let labelHeight = buttonHeight * 0.1
        let labelFontSize = labelHeight * 0.5
        
        let arenaButton = UIButton()
        arenaButton.frame = CGRect(x: buttonGapW, y: topNavBar.maxY + buttonGapH, width: kWidth - buttonGapW * 2, height: buttonHeight)
        arenaButton.backgroundColor = kGreen
        self.addSubview(arenaButton)
        
        let arenaImage = UIImage(named: "arena_icon")
        let arenaImageSize = imageSizeHeight(imageHeight: imageSizeHeightForIcon, imageSize: arenaImage!.size)
        
        let arenaImg = UIButton()
        arenaImg.frame = CGRect(x: arenaButton.w / 2 - arenaImageSize.width / 2, y: arenaButton.h * 0.15, width: arenaImageSize.width, height: arenaImageSize.height)
        arenaImg.setImage(arenaImage, for: .normal)
        arenaButton.addSubview(arenaImg)
        
        let arenaLabel = UIButton()
        arenaLabel.frame = CGRect(x: 0, y: arenaImg.maxY + labelFontSize - 15, width: kWidth, height: labelHeight)
        arenaLabel.setTitle("Arène", for: .normal)
        arenaLabel.setTitleColor(UIColor.white, for: .normal)
        arenaLabel.titleLabel?.textAlignment = .center
        arenaButton.addSubview(arenaLabel)
        
        let bWidth = kWidth / 2 - buttonGapW
        let cartButton = UIButton()
        cartButton.frame = CGRect(x: buttonGapW, y: arenaButton.maxY + buttonGapH, width: bWidth, height: buttonHeight)
        cartButton.backgroundColor = kBlue
        self.addSubview(cartButton)
        
        let cartImage = UIImage(named: "cart_icon")
        let cartImageSize = imageSizeHeight(imageHeight: imageSizeHeightForIcon * 0.7, imageSize: cartImage!.size)
        
        let cartImg = UIButton()
        cartImg.frame = CGRect(x: cartButton.w / 2 - cartImageSize.width - cartImageSize.width * 0.1, y: cartButton.h / 2 - cartImageSize.height / 1.5, width: cartImageSize.width, height: cartImageSize.height)
        cartImg.setImage(cartImage, for: .normal)
        cartButton.addSubview(cartImg)
        
        let cartLabel = UIButton()
        cartLabel.frame = CGRect(x: 0, y: cartImg.maxY + labelFontSize - 10, width: kWidth, height: labelHeight)
        cartLabel.setTitle("Boutique", for: .normal)
        cartLabel.setTitleColor(UIColor.white, for: .normal)
        cartLabel.titleLabel?.textAlignment = .left
        cartLabel.sizeToFit()
        cartLabel.x = (cartImg.minX + cartImg.w / 2) - cartLabel.w / 2 + 5
        cartButton.addSubview(cartLabel)
        
        let profilButton = UIButton()
        profilButton.frame = CGRect(x: cartButton.maxX + buttonGapW, y: cartButton.minY, width: cartButton.w - buttonGapW, height: buttonHeight)
        profilButton.backgroundColor = kOrange
        self.addSubview(profilButton)
        
        let profileImage = UIImage(named: "profile_icon")
        let profileImageSize = imageSizeHeight(imageHeight: imageSizeHeightForIcon * 0.7, imageSize: arenaImage!.size)
        
        let profileImg = UIButton()
        profileImg.frame = CGRect(x: profilButton.w / 2 - profileImageSize.width * 0.1, y: profilButton.h / 2 - profileImageSize.height / 1.5, width: profileImageSize.width, height: profileImageSize.height)
        profileImg.setImage(profileImage, for: .normal)
        profilButton.addSubview(profileImg)
        
        let profileLabel = UIButton()
        profileLabel.frame = CGRect(x: 0, y: profileImg.maxY + labelFontSize - 10, width: kWidth, height: labelHeight)
        profileLabel.setTitle("Profil", for: .normal)
        profileLabel.setTitleColor(UIColor.white, for: .normal)
        profileLabel.titleLabel?.textAlignment = .left
        profileLabel.sizeToFit()
        profileLabel.x = (profileImg.minX + profileImg.w / 2) - profileLabel.w / 2
        profilButton.addSubview(profileLabel)
        
        let chartButton = UIButton()
        chartButton.frame = CGRect(x: buttonGapW, y: profilButton.maxY + buttonGapH, width: arenaButton.w, height: buttonHeight)
        chartButton.backgroundColor = kRed
        self.addSubview(chartButton)
        
        let chartImage = UIImage(named: "chart_icon")
        let chartImageSize = imageSizeHeight(imageHeight: imageSizeHeightForIcon, imageSize: chartImage!.size)
        
        let chartImg = UIButton()
        chartImg.frame = CGRect(x: chartButton.w / 2 - chartImageSize.width / 2, y: chartButton.h * 0.15, width: chartImageSize.width, height: chartImageSize.height)
        chartImg.setImage(chartImage, for: .normal)
        chartButton.addSubview(chartImg)
        
        let chartLabel = UIButton()
        chartLabel.frame = CGRect(x: 0, y: chartImg.maxY + labelFontSize, width: kWidth, height: labelHeight)
        chartLabel.setTitle("Classement", for: .normal)
        chartLabel.setTitleColor(UIColor.white, for: .normal)
        chartLabel.titleLabel?.textAlignment = .center
        chartButton.addSubview(chartLabel)
        
        let newBW = cartButton.w / 1.8
        let playButton = UIButton()
        playButton.frame = CGRect(x: kWidth / 2 - newBW / 2, y: cartButton.minY + cartButton.h / 2 - newBW / 2, width: newBW, height: newBW)
        playButton.backgroundColor = kPurple
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = buttonGapW
        self.addSubview(playButton)
        
        let playImage = UIImage(named: "play_icon")
        let playImageSize = imageSizeHeight(imageHeight: imageSizeHeightForIcon * 0.6, imageSize: playImage!.size)
        
        let playImg = UIButton()
        playImg.frame = CGRect(x: playButton.w / 2 - playImageSize.width / 2, y: playButton.h / 2 - playImageSize.height / 2, width: playImageSize.width, height: playImageSize.height)
        playImg.setImage(playImage, for: .normal)
        playButton.addSubview(playImg)
        
    }
    
    func setUsernameLabel(name: String) {
        self.usernameLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
