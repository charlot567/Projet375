//
//  ViewController.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        kWidth = self.view.frame.width
        kHeight = self.view.frame.height
        kMasterVC = self
        
        let laQuestion = question(id: 1, type: kTypeRegular, categorie: kCat3, quest: "Quel est la couleur de la lune?", reponse: ["Rouge","Vert","Bleu","Blanc"], reponseImage: [UIImage()], imageQuestion: UIImage(), reponseId: 3, location: CLLocationCoordinate2D())
        let q = questionView(frame: self.view.frame, q: laQuestion)
        self.view.addSubview(q)

//        let loginView = LoginView(frame: self.view.frame)
//        self.view.addSubview(loginView)
        
    }
    
    func switchNav(index: Int) {
        if(index == KVHome) {
            print("Switch to home")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

