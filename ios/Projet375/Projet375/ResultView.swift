//
//  ResultView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    init(frame: CGRect, bgColor: UIColor, success: Bool, goodAnswer: String?) {
        super.init(frame: frame)
        
        kUserCurrentTurn += 1
        
        self.backgroundColor = bgColor
        
        let textHeight = kHeight / 20
        let infoLabel = UILabel()
        infoLabel.frame = CGRect(x: kWidth / 6, y: kHeight / 3, width: kWidth - kWidth / 3, height: textHeight)
        infoLabel.text = success ? "Vous avez obtenu la bonne réponse!" : "Vous n'avez pas obtenu la bonne réponse"
        infoLabel.font = UIFont(name: "Helvetica", size: textHeight * 0.9)
        infoLabel.textColor = UIColor.white
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.numberOfLines = 2
        self.addSubview(infoLabel)
        
        let gap = kWidth / 20
        let bHeight = kHeight / 15
        let replayBtn = UIButton()
        replayBtn.frame = CGRect(x: gap, y: kHeight - kHeight * 1.5, width: kWidth - gap * 2, height: bHeight)
        replayBtn.setTitle(kUserCurrentTurn == 3 ? "Terminer" : "Suivant", for: UIControlState.normal)
        replayBtn.setTitleColor(UIColor.white, for: .normal)
        replayBtn.layer.borderWidth = 1
        replayBtn.layer.borderColor = UIColor.white.cgColor
        replayBtn.addTarget(self, action: #selector(replayBtn(button:)), for: .touchUpInside)
        self.addSubview(replayBtn)
    }
    
    func replayBtn(button: UIButton) {
        if(button.titleLabel!.text == "Terminer") {
            
        }
        
        else {
            
        }
        
        print("Replay")
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
