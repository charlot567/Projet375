//
//  ArenaView.swift
//  Projet375
//
//  Created by Alex Morin on 17-02-05.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ArenaView: UIView, CLLocationManagerDelegate, MKMapViewDelegate {

    private var topNavBar: UIView!
    private var titleLabel: UILabel!
    private var hintOverlay: UILabel!
    var showVR = false
    weak var controller:UIViewController!
    var isActive = false;
    var arena: Arena!
    var areneLoc = CLLocationCoordinate2D(latitude: 45.50438399999999, longitude: -73.61288289999999)
    
    let locationManager = CLLocationManager()
    var map = MKMapView()
    
    let margin:CGFloat = 10;
    var v: VrView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        self.backgroundColor = kGreen
        
        topNavBar = UIView()
        topNavBar.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight * 0.1)
        topNavBar.backgroundColor = kBlue
        self.addSubview(topNavBar)
        
        let gap = kWidth / 20
        let textHeight = topNavBar.h * 0.3
        let fontSize = textHeight
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: gap, y: topNavBar.h / 2 - textHeight / 2 + textHeight * 0.3, width: kWidth - gap * 2, height: textHeight)
        titleLabel.font = UIFont(name: "Helvetica", size: fontSize)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = "Arène"
        titleLabel.adjustsFontSizeToFitWidth = true
        self.topNavBar.addSubview(titleLabel)
        
        let backImage = UIImage(named: "back_icon")
        let backSize = imageSize(imageWidth: kWidth / 20, imageSize: backImage!.size)
        let backButton = UIButton()
        backButton.frame = CGRect(x: backSize.width * 0.5, y: topNavBar.h / 2 - backSize.height / 2, width: backSize.width, height: backSize.height)
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.topNavBar.addSubview(backButton)
        
        map = MKMapView(frame: CGRect(x: margin/2, y: margin/2 + topNavBar.frame.maxY, width: self.frame.width - margin, height: self.frame.height - margin - topNavBar.frame.maxY))
        map.showsUserLocation = true
        map.delegate = self
        self.addSubview(map)
        
        hintOverlay = UILabel(frame: CGRect(x: CGFloat(10), y: topNavBar.frame.maxY+CGFloat(10), width: self.frame.width - 20 , height: self.frame.height * 0.1))
        hintOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        hintOverlay.text = "Trouve des arènes a conquérir!"
        hintOverlay.layer.cornerRadius = 20;
        hintOverlay.clipsToBounds = true
        hintOverlay.textAlignment = NSTextAlignment.center
        self.addSubview(hintOverlay)
        
        let circle = MKCircle(center: areneLoc, radius: 500)
        map.add(circle)
        

    }
    
    func load() {
        //  Arena disponible
//        self.arena
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        if(isActive) {
        
            let c = CLCircularRegion(center: areneLoc, radius: 500, identifier: "circle")
            if c.contains(location.coordinate) {
            //on affiche la vue VR
                if(showVR == false) {
                
                    let alert = UIAlertController(title: "Alerte d'Arène", message: "Une arène est sur votre chemin voulez vous combattre?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Oui", style: UIAlertActionStyle.default, handler: { action in
                        self.v = VrView(frame: self.map.frame)
                        self.v.arena = self.arena
                        self.v.clipsToBounds = true
                        self.addSubview(self.v)
                        
                        //QuestionView(frame: CGRect(x:,y:,width), q: <#T##question#>, match: <#T##Match#>, background: false)
                        
                        //v.addViewToLocation(view: , toAdd: <#T##CLLocationCoordinate2D#>)
                        let button = self.v.addLocationToView(toAdd: self.areneLoc)
                        button.addTarget(self, action: #selector(self.pressedArena(sender:)), for: UIControlEvents.touchUpInside)
                        self.showVR=true
                        self.load()
                    }))
                
                    alert.addAction(UIAlertAction(title: "Non", style: UIAlertActionStyle.destructive, handler: nil))
                    self.getCurrentViewController()!.present(alert, animated: true, completion: nil)
                }
            }
        }
        self.map.setRegion(region, animated: false)
    }
    
    func back() {
        print("back")
        
        if(nbQuestionReussiUser > arena.nbQuestionReussi) {
            ControllerArena.setArena(arenaId: arena.id, nbQuestionReussi: nbQuestionReussiUser, completitionHandler: { (success: Bool) in
                print(success)
            })
            
        }
        
        
        
        nbQuestionReussiUser = 0
        
        kMasterVC.switchNav(index: KVHome)
    }
    
    func pressedArena(sender: UIButton) {
        print("Image")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        overlayRenderer.lineWidth = 1.0
        overlayRenderer.strokeColor = UIColor.black
        overlayRenderer.fillColor = UIColor.black.withAlphaComponent(0.2)
        return overlayRenderer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }

}
