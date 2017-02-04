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
let kGreen: UIColor  = UIColor(colorLiteralRed: 124/255, green: 184/255, blue: 214/255, alpha: 1.0)
let kOrange: UIColor = UIColor(colorLiteralRed: 245/255, green: 144/255, blue: 35/255, alpha: 1.0)
let kPurple: UIColor = UIColor(colorLiteralRed: 147/255, green: 93/255, blue: 64/255, alpha: 1.0)

//Les urls de l'API
let kBaseUrl:String = "http://79.170.44.147/projet-375.org/API"


//Les catégories de questions
let kCat1:String = "Cat1"
let kCat2:String = "Cat2"
let kCat3:String = "Cat3"
let kCat4:String = "Cat4"

let kColorForCategories: [String:UIColor] = [kCat1:kRed, kCat2:kBlue, kCat3:kGreen, kCat4:kOrange]

//Les type de questions
let kTypeMap:Int     = 0
let kTypeRegular:Int = 1
let kTypePicture:Int = 2




