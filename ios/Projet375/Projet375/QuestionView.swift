//
//  questionView.swift
//  Projet375
//
//  Created by Alex Morin on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//
import UIKit
import MapKit

class QuestionView: UIView, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var resultView: ResultView!
    let locationManager = CLLocationManager()
    
    var navBar: UINavigationBar
    var questionLabel: UILabel
    let margin:CGFloat = 10
    let marginB: CGFloat = 15
    let verticalMargin: CGFloat = 22
    let mapMargin: CGFloat = 20
    var buttons: [UIButton]
    var loadingBar: UIView
    var time = 10;
    var timer: Timer;
    var timeLabel: UILabel
    var headerHeight = CGFloat(0);
    var map: MKMapView
    var lgpr: UILongPressGestureRecognizer
    var hasAnswer = false
    var match: Match!
    var background: Bool
    
    var que = question(id: -1, type: -1, categorie: "", quest: "", reponse: ["","","",""], reponseImage: [UIImage()], reponseId: -1, location: CLLocationCoordinate2D())
    
    override init(frame: CGRect) {
        navBar = UINavigationBar()
        questionLabel = UILabel()
        buttons = []
        loadingBar = UIView()
        timer = Timer()
        timeLabel = UILabel()
        map = MKMapView()
        lgpr = UILongPressGestureRecognizer()
        background = true
        super.init(frame: frame)
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    init(frame: CGRect, q: question, match: Match, background: Bool) {
        self.match = match
        navBar = UINavigationBar()
        questionLabel = UILabel()
        buttons = []
        que = q
        loadingBar = UIView()
        timer = Timer()
        timeLabel = UILabel()
        map = MKMapView()
        lgpr = UILongPressGestureRecognizer()
        self.background = background
        super.init(frame:frame)
        
        let bg = UIView()
        bg.frame = self.frame
        bg.backgroundColor = kColorForCategories[q.categorie]
        self.addSubview(bg)
        
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        createHeader(cat: que.categorie)
        
        
        
        
        switch que.type {
        case kTypeMap:
            //On load la view reguliere question réponse
            createRegularContent()
        //print("Regular")
        case kTypeRegular:
            //On load la view map
            createMapContent()
            
        default:
            //On fait rien...
            print("Does not work...")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHeader(cat: String) {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.1))
        navBar.barStyle = UIBarStyle.default
        
        let color = [kGreen, kPurple, kBlue, kRed]
        navBar.barTintColor = color[Int(cat)!]
        self.backgroundColor = color[Int(cat)!]
        
        loadingBar.backgroundColor = UIColor.blue
        
        let navItem = UINavigationItem(title: cat == "0" ? "Géographie" : cat == "1" ? "Histoire" : cat == "2" ? "Tourisme" : "Art");
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navBar.setItems([navItem], animated: false);
        
        self.loadingBar.frame = CGRect(x: 0, y: navBar.frame.maxY - 1, width: self.frame.width, height: 4)
        UIView.animate(withDuration: 11, animations: {
            self.loadingBar.frame = CGRect(x: 0, y: self.navBar.frame.maxY - 1, width: 0, height: 4)
        })
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: loadingBar.maxY, width: self.frame.width, height: self.frame.height*0.08))
        self.timeLabel.text = "10"
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 35)
        timeLabel.textColor = UIColor.white
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            if(self.time > 0) {
                self.time = self.time - 1
                DispatchQueue.main.async{
                    self.timeLabel.text = "\(self.time)"
                };
            } else {
                self.timer.invalidate()
                self.timesUp()
            }
        })
        if(background) {
            self.addSubview(timeLabel)
            self.addSubview(loadingBar)
            self.addSubview(navBar)
        }
        
        headerHeight = self.timeLabel.maxY
    }
    
    func createRegularContent() {
        
        questionLabel = UILabel(frame: CGRect(x: margin, y: headerHeight + margin, width: self.frame.width - 2*margin, height: self.frame.height*0.2))
        questionLabel.font = UIFont(name: questionLabel.font.fontName, size: 20)
        questionLabel.text = que.quest
        questionLabel.textColor = UIColor.black
        //questionLabel.layer.borderWidth = 2
        questionLabel.backgroundColor = kBeige
        
        //questionLabel.layer.borderColor = (UIColor.white).cgColor
        questionLabel.numberOfLines = 3
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.layer.cornerRadius = 20
        questionLabel.clipsToBounds = true
        
        let buttonHeight = (self.frame.height - self.questionLabel.maxY-(5*marginB)/2)/6
        
        for index in 0...3 {
            let button = UIButton(frame: CGRect(x: marginB/2, y: verticalMargin*2 + questionLabel.frame.maxY + (CGFloat(index)*buttonHeight) + marginB/2 + marginB/2*CGFloat(index), width: self.frame.width - marginB, height: buttonHeight))
            button.setTitleColor(UIColor.black, for: [])
            button.setTitle(que.reponse![index], for: [])
            button.backgroundColor = kBeige
            //button.layer.borderWidth = 2
            //button.layer.borderColor = (UIColor.white).cgColor
            button.layer.cornerRadius = button.frame.height/2
            button.tag = index
            button.addTarget(self, action: #selector(checkAnswer(sender:)), for: UIControlEvents.touchUpInside)
            button.clipsToBounds = true
            buttons.append(button)
            self.addSubview(buttons[index])
        }
        self.addSubview(questionLabel)
    }
    
    func checkAnswer(sender: UIButton) {
        if(sender.tag == que.reponseId) {
            sender.layer.borderWidth = 4
            sender.layer.borderColor = (UIColor.green).cgColor
            sender.layer.cornerRadius = 20
            sender.setTitleColor(UIColor.green, for: [])
            hasAnswer = true
            userHasWon()
            kGoodAnswer += 1
        } else {
            sender.layer.borderWidth = 4
            sender.layer.borderColor = (UIColor.red).cgColor
            sender.layer.cornerRadius = 20
            sender.setTitleColor(UIColor.red, for: [])
            hasAnswer = false
            userHasLost()
        }
        for b in buttons {
            b.isEnabled = false
        }
        
        self.resultView = ResultView(frame: self.frame, bgColor: self.backgroundColor!, success: sender.tag == que.reponseId, goodAnswer: self.que.reponse?[que.reponseId], match: match)
        
        self.timer.invalidate()
        self.loadingBar.layer.removeAllAnimations()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayResultView), userInfo: nil, repeats: false)
    }
    
    func displayResultView() {
        resultView.frame.origin.y = kHeight
        self.addSubview(resultView)
        
        UIView.animate(withDuration: 0.5) {
            self.resultView.frame.origin.y = 0
        }
        
    }
    
    func timesUp() {
        self.resultView = ResultView(frame: self.frame, bgColor: self.backgroundColor!, success: false, goodAnswer: "",  match: match)
        
        self.timer.invalidate()
        self.loadingBar.layer.removeAllAnimations()
        
        displayResultView()
        //
        //        if (que.type == kTypeRegular) {
        //            for index in 0...3 {
        //                buttons[index].isEnabled = false
        //            }
        //            displayRegularAnswer()
        //        } else if(que.type == kTypeMap) {
        //            lgpr.isEnabled = false
        //            displayMapAnswer()
        //        } else {
        //            print("on sait pas quoi faire encore...")
        //        }
    }
    
    
    
    func createMapContent() {
        questionLabel = UILabel(frame: CGRect(x: margin, y: headerHeight + margin, width: self.frame.width - 2*margin, height: self.frame.height*0.2))
        questionLabel.font = UIFont(name: questionLabel.font.fontName, size: 20)
        questionLabel.text = que.quest
        //questionLabel.layer.borderWidth = 2
        
        //questionLabel.layer.borderColor = (UIColor.white).cgColor
        questionLabel.numberOfLines = 3
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.textColor = UIColor.black
        questionLabel.backgroundColor = kBeige
        questionLabel.layer.cornerRadius = 20
        questionLabel.clipsToBounds = true
        
        map = MKMapView(frame: CGRect(x: mapMargin/2, y: questionLabel.frame.maxY + mapMargin/2, width: self.frame.width - mapMargin, height: (self.frame.height - questionLabel.frame.maxY) - mapMargin))
        map.delegate = self
        map.showsUserLocation = true
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        
        map.layer.borderWidth = 2
        map.layer.borderColor = (UIColor.white).cgColor
        map.layer.cornerRadius = 20
        map.clipsToBounds = true
        
        lgpr = UILongPressGestureRecognizer()
        lgpr.addTarget(self, action: #selector(pressed(sender: )))
        lgpr.minimumPressDuration = 0.1
        
        
        self.addSubview(map)
        self.addSubview(questionLabel)
        map.addGestureRecognizer(lgpr)
    }
    
    func pressed(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: map)
        let locationCoordinate = map.convert(touchLocation, toCoordinateFrom: map)
        
        let point = MKPointAnnotation()
        point.coordinate = locationCoordinate;
        self.map.addAnnotation(point)
        
        
        let c = CLCircularRegion(center: que.location!, radius: 2000, identifier: "circle")
        if c.contains(locationCoordinate) {
            hasAnswer = true
            userHasWon()
        } else {
            hasAnswer = false
            userHasLost()
        }
        
        self.resultView = ResultView(frame: self.frame, bgColor: self.backgroundColor!, success: hasAnswer, goodAnswer: "", match: match)
        timer.invalidate()
        lgpr.isEnabled = false
        displayMapAnswer()
        
        self.loadingBar.layer.removeAllAnimations()
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(displayResultView), userInfo: nil, repeats: false)
        
    }
    
    func displayMapAnswer() {
        let circle = MKCircle(center: que.location!, radius: 1000)
        map.add(circle)
    }
    
    func displayRegularAnswer() {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        self.map.setRegion(region, animated: false)
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        if (hasAnswer) {
            overlayRenderer.lineWidth = 1.0
            overlayRenderer.strokeColor = UIColor.green
            overlayRenderer.fillColor = UIColor.green.withAlphaComponent(0.4)
        } else {
            overlayRenderer.lineWidth = 1.0
            overlayRenderer.strokeColor = UIColor.red
            overlayRenderer.fillColor = UIColor.red.withAlphaComponent(0.4)
        }
        return overlayRenderer
    }
    
    func userHasWon() {
        print("The user has won!")
    }
    
    func userHasLost() {
        print("The user has lost!")
    }
}
