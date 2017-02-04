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
        let imageSizeHeightForIcon = buttonHeight * 0.5
        
        let arenaButton = UIButton()
        arenaButton.frame = CGRect(x: buttonGapW, y: topNavBar.maxY + buttonGapH, width: kWidth - buttonGapW * 2, height: buttonHeight)
        arenaButton.backgroundColor = kGreen
        self.addSubview(arenaButton)
        
        let bWidth = kWidth / 2 - buttonGapW
        let otherButton = UIButton()
        otherButton.frame = CGRect(x: buttonGapW, y: arenaButton.maxY + buttonGapH, width: bWidth, height: buttonHeight)
        otherButton.backgroundColor = kBlue
        self.addSubview(otherButton)
        
        let profilButton = UIButton()
        profilButton.frame = CGRect(x: otherButton.maxX + buttonGapW, y: otherButton.minY, width: otherButton.w - buttonGapW, height: buttonHeight)
        profilButton.backgroundColor = kOrange
        self.addSubview(profilButton)
        
        let chartButton = UIButton()
        chartButton.frame = CGRect(x: buttonGapW, y: profilButton.maxY + buttonGapH, width: arenaButton.w, height: buttonHeight)
        chartButton.backgroundColor = kRed
        self.addSubview(chartButton)
        
        let chartImage = UIImage(named: "chart_icon")
        let chartImageSize = imageSizeHeight(imageHeight: imageSizeHeightForIcon, imageSize: chartImage!.size)
        
        let chartImg = UIButton()
        chartImg.frame = CGRect(x: chartButton.w / 2, y: chartButton.h * 0.2, width: chartImageSize.width, height: chartImageSize.height)
        chartImg.setImage(chartImage, for: .normal)
        chartButton.addSubview(chartImg)
        
        
        let newBW = otherButton.w / 1.5
        let playButton = UIButton()
        playButton.frame = CGRect(x: kWidth / 2 - newBW / 2, y: otherButton.minY + otherButton.h / 2 - newBW / 2, width: newBW, height: newBW)
        playButton.backgroundColor = kPurple
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = buttonGapW
        self.addSubview(playButton)
        
    }
    
    func setUsernameLabel(name: String) {
        self.usernameLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
