//
//  question.swift
//  Projet375
//
//  Created by Alex Morin on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class question {
    var id: Int!
    var type:Int!
    var categorie:String!
    var quest: String!
    var reponse:[String]?           //Liste des réponse possible sous forme de texte
    var reponseImage:[UIImage]?     //Tableau des images représentant des questions
    var imageQuestion:UIImage?      //L'image représentant la question
    var reponseId:Int!              //Le numéro de la réponse
    var location: CLLocationCoordinate2D?
    
    init(id: Int, type:Int ,categorie:String, quest: String, reponse:[String], reponseImage:[UIImage], imageQuestion:UIImage, reponseId:Int, location: CLLocationCoordinate2D) {
        self.id = id
        self.type = type
        self.categorie = categorie
        self.quest = quest
        self.reponse = reponse
        self.reponseImage = reponseImage
        self.imageQuestion = imageQuestion
        self.reponseId = reponseId
        self.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    func getQuestion(for categorie: String, type: Int) {
        print("Get question")
    }
    
    
}
