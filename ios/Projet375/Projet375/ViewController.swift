//
//  ViewController.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import MapKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import SwiftSpinner

class ViewController: UIViewController {

    private var menuView: MenuView!
    private var loginView: LoginView!
    private var randomView: RandomPickerView!
    private var chartView: ChartView!
    private var arenaView: ArenaView!
    private var profileView: ProfileView!
    var currentMatch: Match!
    
    private var currentViewIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        kWidth = self.view.frame.width
        kHeight = self.view.frame.height
        kMasterVC = self
        
        //  Init View
        menuView = MenuView(frame: self.view.frame)
        loginView = LoginView(frame: self.view.frame)
        chartView = ChartView(frame: self.view.frame)
        profileView = ProfileView(frame: self.view.frame)
        arenaView = ArenaView(frame: self.view.frame)
//        randomView = RandomPickerView(frame: self.view.frame)
        
        self.currentViewIndex = KVLogIn
        
        //  Check if we need to display the login page
        if AccessToken.current != nil {
            createCurrentUser { (success: Bool) in
                
                if(success) {
                    self.switchNav(index: KVHome)
                }
                
                else { self.switchNav(index: KVLogIn) }
                
            }
        } else { self.switchNav(index: KVLogIn) }
    
        kCurrentUser.getProfileImage { (image: UIImage?) in }
    }
    
    func switchNav(index: Int) {
        SwiftSpinner.hide()
        
        loginView.removeFromSuperview()
        
        if(self.currentViewIndex == KVChart) {
            UIView.animate(withDuration: 0.5, animations: { 
                self.chartView.x = kWidth
            })
            arenaView.isActive = false
        }
        
        if(self.currentViewIndex == KVProfile) {
            UIView.animate(withDuration: 0.5, animations: {
                self.profileView.x = kWidth
            })
            arenaView.isActive = false
        }
        
        if(self.currentViewIndex == KVArena) {
            arenaView.isActive = false
            UIView.animate(withDuration: 0.5, animations: {
                self.arenaView.x = kWidth
            })
        }
        
        if(index == KVHome && self.currentViewIndex != KVChart && self.currentViewIndex != KVProfile) {
            self.view.addSubview(menuView)
            self.menuView.setUsernameLabel(name: kCurrentUser.firstName)
            arenaView.isActive = false
        }
        
        else if(index == KVLogIn) {
            self.view.addSubview(loginView)
            arenaView.isActive = false
        }
            
        else if(index == KVChart) {
            chartView.x = kWidth
            arenaView.isActive = false
            UIView.animate(withDuration: 0.5, animations: {
                self.chartView.x = 0
            })
            
            chartView.loadData()
            self.view.addSubview(chartView)
        }
            
        else if(index == KVArena) {
            arenaView.x = kWidth
            arenaView.isActive = true
            
            UIView.animate(withDuration: 0.5, animations: {
                self.arenaView.x = 0
            })
            self.view.addSubview(arenaView)
        }
            
        else if(index == KVProfile) {
            profileView.x = kWidth
            arenaView.isActive = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.profileView.x = 0
            })
            
            self.profileView.showPage()
            self.view.addSubview(profileView)
        }
        
        else if(index == KVPlay) {
            
            //  Need to fetch match
            if(self.currentMatch == nil) {
                ControllerMatch.getMatch { (succesMatch: Bool, match: Match?) in
                    
                    if(succesMatch && match != nil) {
                        
                        DispatchQueue.main.sync {
                            self.currentMatch = match
                            self.randomView = RandomPickerView(frame: self.view.frame, match: match!)
                            self.randomView.y = kHeight
                            self.view.addSubview(self.randomView)
                            self.randomView.generateCategory()
                            
                            UIView.animate(withDuration: 0.5, animations: { 
                                self.randomView.y = 0
                            })
                        }
                    }
                        
                    else {
                        displayAlert(currentViewController: self, title: "Erreur", message: "Problème lors de la récupération du match")
                    }
                }
            }
            
            else {
                
//                DispatchQueue.main.sync {
//                    print(self.randomView)
                    self.view.addSubview(self.randomView)
                    self.randomView.generateCategory()
//                }
            }
        }
        
        else if(index == KVCart) {
            displayAlert(currentViewController: kMasterVC, title: "Info", message: "Page panier")
        }
        self.currentViewIndex = index
        
        print(index)
        
        
    }
    
    func resultToQuestion() {
        self.randomView.questionView.resultView.removeFromSuperview()
        self.randomView.questionView.removeFromSuperview()
        self.randomView.removeFromSuperview()
        switchNav(index: KVPlay)
    }
    
    func resultToMenu() {
        self.randomView.questionView.resultView.removeFromSuperview()
        self.randomView.questionView.removeFromSuperview()
        self.randomView.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

