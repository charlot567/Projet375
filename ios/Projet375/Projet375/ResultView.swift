//
//  ResultView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    var match: Match!
    init(frame: CGRect, bgColor: UIColor, success: Bool, goodAnswer: String?, match: Match) {
        super.init(frame: frame)
        self.match = match
        kUserCurrentTurn += 1
        
        self.backgroundColor = bgColor
        
        let textHeight = kHeight / 15
        let infoLabel = UILabel()
        infoLabel.frame = CGRect(x: kWidth / 6, y: kHeight / 3, width: kWidth - kWidth / 3, height: textHeight)
        infoLabel.text = success ? "Vous avez obtenu la bonne réponse!" : "Vous n'avez pas obtenu la bonne réponse"
        infoLabel.font = UIFont(name: "Helvetica", size: textHeight * 0.9)
        infoLabel.textColor = UIColor.white
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.numberOfLines = 2
        infoLabel.textAlignment = .center
        self.addSubview(infoLabel)
        
        let gap = kWidth / 20
        let bHeight = kHeight / 15
        let replayBtn = UIButton()
        replayBtn.frame = CGRect(x: gap, y: kHeight - bHeight * 1.5, width: kWidth - gap * 2, height: bHeight)
        replayBtn.setTitle(kUserCurrentTurn == 3 ? "Terminé" : "Suivant", for: UIControlState.normal)
        replayBtn.setTitleColor(UIColor.white, for: .normal)
        replayBtn.layer.borderWidth = 1
        replayBtn.layer.borderColor = UIColor.white.cgColor
        replayBtn.addTarget(self, action: #selector(replayBtn(button:)), for: .touchUpInside)
        self.addSubview(replayBtn)
    }
    
    func replayBtn(button: UIButton) {
        if(button.titleLabel!.text == "Terminer") {
            kMasterVC.resultToMenu()
            kUserCurrentTurn = 0
            kMasterVC.currentMatch = nil
            
            if(match.state == kNewMatch) {
                //  Send stats to create new match
                //  SetMatch
                ControllerMatch.setMatch(playerId: kCurrentUser.fbId, score: kGoodAnswer, completitionHandler: { (success: Bool) in
                    
                    if(!success) {
                        displayAlert(currentViewController: kMasterVC, title: "Erreur", message: "Le match n'a pas été sauvegardé")
                    }
                })
            }
            
            else {
                //  Send final score of the game + say the result to the user
                
                if(kGoodAnswer > match.score) {
                    displayAlert(currentViewController: kMasterVC, title: "Résultat", message: "Vous avez gagnez le match! \(kGoodAnswer)-\(match.score!)")
                }
                
                else if(kGoodAnswer == match.score) {
                    displayAlert(currentViewController: kMasterVC, title: "Résultat", message: "Vous avez égalisé le match! \(kGoodAnswer)-\(match.score!)")
                }
                
                else {
                    displayAlert(currentViewController: kMasterVC, title: "Résultat", message: "Vous avez perdu le match! \(kGoodAnswer)-\(match.score!)")
                }
                
                ControllerMatch.setScore(playerId: kCurrentUser.fbId, score: kGoodAnswer, token: match.opposantToken == nil ? "NOTOKEN" : match.opposantToken, completitionHandler: { (success: Bool) in
                    if(!success) {
                        displayAlert(currentViewController: kMasterVC, title: "Erreur", message: "Le match n'a pas été sauvegardé")
                    }
                })
            }
            
            kGoodAnswer = 0
        }
        
        else {
            kMasterVC.resultToQuestion()
        }
        
        print("Replay")
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
