//
//  ChartView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-05.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import SwiftSpinner

class ChartView: UIView {
    
    private var topNavBar: UIView!
    private var titleLabel: UILabel!
    
    private var userCharts = [UserChart]()
    private var profileImageUserC = [UIImageView]()
    private var userChartsView = [UIView]()
    private var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bg = UIImageView()
        bg.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight)
        bg.image = UIImage(named: "bg_score")
        self.addSubview(bg)
        
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
        titleLabel.text = "Classement"
        titleLabel.adjustsFontSizeToFitWidth = true
        self.topNavBar.addSubview(titleLabel)
        
        let backImage = UIImage(named: "back_icon")
        let backSize = imageSize(imageWidth: kWidth / 20, imageSize: backImage!.size)
        let backButton = UIButton()
        backButton.frame = CGRect(x: backSize.width * 0.5, y: topNavBar.h / 2 - backSize.height / 2, width: backSize.width, height: backSize.height)
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.topNavBar.addSubview(backButton)
        
//        self.backgroundColor = UIColor.red
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: topNavBar.maxY, width: kWidth, height: kHeight - topNavBar.maxY)
        self.addSubview(scrollView)
    }
    
    func back() {
        print("back")
        kMasterVC.switchNav(index: KVHome)
    }
    
    
    func loadData() {
        SwiftSpinner.show("Récupération du classement")
        ControllerChart.getChart { (succes: Bool, myScore: Int, userCharts: [UserChart]?) in
            if(succes && userCharts != nil) {
                self.userCharts = userCharts!
                
                DispatchQueue.main.sync {
                    
                    for v in self.scrollView.subviews {
                        v.removeFromSuperview()
                    }
                    self.userChartsView.removeAll()
                    
                    for uc in self.userCharts {
                        let y = self.userChartsView.count == 0 ? 0 : self.userChartsView.last!.maxY + 10
                        let view = UIView()
                        view.frame = CGRect(x: 0, y: y, width: kWidth, height: kHeight / 8)
                        view.backgroundColor = UIColor.white
                        view.layer.borderWidth = 1
                        view.layer.borderColor = UIColor.white.cgColor
                        view.layer.zPosition = 1000
                        
                        let texHeight = kHeight / 25
                        let usernameLabel = UILabel()
                        usernameLabel.frame = CGRect(x: kWidth / 20, y: 0, width: kWidth - kWidth / 2.5, height: texHeight)
                        usernameLabel.font = UIFont(name: "Helvetica", size: texHeight * 0.8)
                        usernameLabel.text = uc.playerCompleteName!
                        usernameLabel.text = usernameLabel.text!.replacingOccurrences(of: "Ã»", with: "û")
                        usernameLabel.textColor = UIColor.black
                        usernameLabel.y = view.h / 2 - usernameLabel.h / 2
                        view.addSubview(usernameLabel)
                        
                        let pointLabel = UILabel()
                        pointLabel.frame = CGRect(x: usernameLabel.maxX + 20, y: 0, width: kWidth - usernameLabel.maxX + 20 - 20, height: texHeight)
                        pointLabel.font = UIFont(name: "Helvetica", size: texHeight * 0.8)
                        pointLabel.text = "Pt: \(uc.point!)"
                        pointLabel.textColor = UIColor.black
                        pointLabel.y = usernameLabel.minY
                        view.addSubview(pointLabel)
                        
                        view.layer.shadowColor = UIColor.black.cgColor
                        view.layer.shadowRadius = 5
                        
                        self.scrollView.addSubview(view)
                        self.userChartsView.append(view)
                        self.scrollView.contentSize = CGSize(width: kWidth, height: self.userChartsView.last!.maxY)
                        
                    }
                    
                    SwiftSpinner.hide()
                }
            }
                
            else {
                displayAlert(currentViewController: kMasterVC, title: "Erreur", message: "Problème lors de la récupération du classement")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
}
