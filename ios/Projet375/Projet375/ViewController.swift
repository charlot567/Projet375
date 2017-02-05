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
    
    }
    
    func switchNav(index: Int) {
        SwiftSpinner.hide()
        
        loginView.removeFromSuperview()
        
        if(index == KVHome) {
            self.view.addSubview(menuView)
            self.menuView.setUsernameLabel(name: kCurrentUser.firstName)
        }
        
        else if(index == KVLogIn) {
            self.view.addSubview(loginView)
        }
        
        else if(index == KVPlay) {
            
            //  Need to fetch match
            if(self.currentMatch == nil) {
                ControllerMatch.getMatch { (succesMatch: Bool, match: Match?) in
                    
                    if(succesMatch && match != nil) {
                        
                        DispatchQueue.main.sync {
                            self.currentMatch = match
                            self.randomView = RandomPickerView(frame: self.view.frame, match: match!)
                            self.view.addSubview(self.randomView)
                            self.randomView.generateCategory()
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

