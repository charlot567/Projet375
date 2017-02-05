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
        
        if(!success && goodAnswer != nil && !(goodAnswer?.isEmpty)!) {
            let answerLabel = UILabel()
            answerLabel.frame = CGRect(x: kWidth / 6, y: infoLabel.maxY + kHeight / 20, width: kWidth - kWidth / 3, height: textHeight)
            answerLabel.text = "La réponse était:"
            answerLabel.font = UIFont(name: "Helvetica", size: textHeight * 0.9)
            answerLabel.textColor = UIColor.white
            answerLabel.adjustsFontSizeToFitWidth = true
            answerLabel.numberOfLines = 2
            answerLabel.textAlignment = .center
            self.addSubview(answerLabel)
            
            let textViewHeight = kHeight / 5
            let gapV = kWidth / 20
            let answerTextView = UITextView()
            answerTextView.frame = CGRect(x: gapV, y: answerLabel.maxY + kHeight / 40, width: kWidth - gapV * 2, height: textViewHeight)
            answerTextView.isEditable = false
            answerTextView.isSelectable = false
            answerTextView.backgroundColor = UIColor.clear
            answerTextView.text = goodAnswer == nil ? "" : goodAnswer!
            answerTextView.textAlignment = .center
            answerTextView.textColor = UIColor.white
            answerTextView.font = UIFont(name: "Helvetica", size: kHeight / 20 * 0.7)
            self.addSubview(answerTextView)
        }
        
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
        if(button.titleLabel!.text == "Terminé") {
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
                
                var pointage_1 = 0;
                var pointage_2 = 0;
                
                if(kGoodAnswer > match.score) {
                    displayAlert(currentViewController: kMasterVC, title: "Résultat", message: "Vous avez gagnez le match! \(kGoodAnswer)-\(match.score!)")
                    pointage_1 = 2;
                }
                    
                else if(kGoodAnswer == match.score) {
                    displayAlert(currentViewController: kMasterVC, title: "Résultat", message: "Vous avez égalisé le match! \(kGoodAnswer)-\(match.score!)")
                    pointage_1 = 1;
                    pointage_2 = 1;
                }
                    
                else {
                    displayAlert(currentViewController: kMasterVC, title: "Résultat", message: "Vous avez perdu le match! \(kGoodAnswer)-\(match.score!)")
                    pointage_2 = 2;
                }
                
                ControllerMatch.setScore(playerId: kCurrentUser.fbId, score: pointage_1, token: "NOTOKEN", completitionHandler: { (success: Bool) in
                    if(!success) {
                        displayAlert(currentViewController: kMasterVC, title: "Erreur", message: "Le match n'a pas été sauvegardé")
                    }
                })
                
                ControllerMatch.setScore(playerId: match.opposantPlayerId, score: pointage_2, token: match.opposantToken == nil ? "NOTOKEN" : match.opposantToken, completitionHandler: { (success: Bool) in
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
