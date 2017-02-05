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
        
        self.currentViewIndex = KVLogIn
//        DispatchQueue.main.async { SwiftSpinner.show("Chargement") }
        
        //  Check if we need to display the login page
        if AccessToken.current != nil {
            createCurrentUser { (success: Bool) in
                
                if(success) {
                    self.switchNav(index: KVHome)
                }
                
                else { self.switchNav(index: KVLogIn) }
                
            }
        } else { self.switchNav(index: KVLogIn) }
        

        
        
//        let laQuestion = question(id: 1, type: kTypeRegular, categorie: kCat3, quest: "Quel est la couleur de la lune?", reponse: ["Rouge","Vert","Bleu","Blanc"], reponseImage: [UIImage()], imageQuestion: UIImage(), reponseId: 3, location: CLLocationCoordinate2D())
//        let q = questionView(frame: self.view.frame, q: laQuestion)
//        self.view.addSubview(q)

        
        
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
        
        self.currentViewIndex = index
        
        print(index)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

