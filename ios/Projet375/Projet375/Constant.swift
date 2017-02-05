//
//  Constant.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit

//Les dimensions de l'iPhone
var kWidth: CGFloat!
var kHeight: CGFloat!


//Les couleur de l'application
let kRed: UIColor    = UIColor(colorLiteralRed: 124/255, green: 0, blue: 0, alpha: 1.0)
let kBlue: UIColor   = UIColor(colorLiteralRed: 85/255, green: 168/255, blue: 214/255, alpha: 1.0)
let kGreen: UIColor  = UIColor(colorLiteralRed: 124/255, green: 184/255, blue: 69/255, alpha: 1.0)
let kOrange: UIColor = UIColor(colorLiteralRed: 245/255, green: 144/255, blue: 35/255, alpha: 1.0)
let kPurple: UIColor = UIColor(colorLiteralRed: 148/255, green: 75/255, blue: 64/255, alpha: 1.0)

//Les urls de l'API
let kBaseUrl:String = "http://79.170.44.147/projet-375.org/API"


//Les catégories de questions
let kCat1:String = "Géographie"
let kCat2:String = "Histoire"
let kCat3:String = "Tourisme"
let kCat4:String = "Art"

let kColorForCategories: [String:UIColor] = [kCat1:kGreen, kCat2:kPurple, kCat3:kBlue, kCat4:kRed]

//Les type de questions
let kTypeMap:Int     = 0
let kTypeRegular:Int = 1
let kTypePicture:Int = 2

var kCurrentUser: User!

var kMasterVC: ViewController!

let KVLogIn = 0
let KVHome = 1
let KVArena = 2
let KVCart = 3
let KVPlay = 4
let KVProfile = 5
let KVChart = 6

var kUserCurrentTurn: Int = 0
