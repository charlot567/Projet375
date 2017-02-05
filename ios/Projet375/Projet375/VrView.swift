//
//  VrView.swift
//  vision!
//
//  Created by Alex Morin on 17-02-05.
//  Copyright © 2017 CodingPanda. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation
import CoreLocation

class VrView: UIView, CLLocationManagerDelegate {
    
    var DyawLabel: UILabel!
    var DpitchLabel: UILabel!
    var DrollLabel: UILabel!
    var DheadingLabel: UILabel!
    var DlocationLabel: UILabel!
    var location = CLLocationCoordinate2D()
    let DEBUG = false
    let DebugColor = UIColor.red
    
    var motionManager: CMMotionManager!
    var captureDevice: AVCaptureDevice?
    var captureSession: AVCaptureSession!
    var locationManager: CLLocationManager!
    var halfInfiniteWall1: UIView!
    var halfInfiniteWall2: UIView!
    
    var deviceWidth = CGFloat(0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (status) in
            if(status) {
                self.captureSession = AVCaptureSession()
                self.captureSession.sessionPreset = AVCaptureSessionPresetHigh
                
                let devices = AVCaptureDevice.devices()
                
                for device in devices! {
                    if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)) {
                        if((device as AnyObject).position == AVCaptureDevicePosition.back) {
                            self.captureDevice = device as? AVCaptureDevice
                        }
                    }
                    
                }
                if(self.captureDevice != nil) {
                    self.beginCameraSession()
                }
            } else {
                print("Impossible de lancer la camera")
            }
        }
        
        deviceWidth = self.frame.width
        
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        halfInfiniteWall1 = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width*5, height: self.frame.height))
        halfInfiniteWall2 = UIView(frame: CGRect(x: halfInfiniteWall1.frame.width, y: 0, width: self.frame.width*5, height: self.frame.height))
        
        self.addSubview(halfInfiniteWall1)
        self.addSubview(halfInfiniteWall2)
        
        
        
        //221 a 255 ... 360/(255 - 221) = 10.58  disons 10 pour les tests...
        
        
        var tim = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
            self.updateMotion()
        })
        
        if DEBUG {
            DyawLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.frame.width, height: 20))
            DpitchLabel = UILabel(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 20))
            DrollLabel = UILabel(frame: CGRect(x: 0, y: 60, width: self.frame.width, height: 20))
            DheadingLabel = UILabel(frame: CGRect(x: 0, y: 80, width: self.frame.width, height: 20))
            DlocationLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.frame.width, height: 20))
            
            DyawLabel.text = "Yaw: "
            DpitchLabel.text = "Pitch: "
            DrollLabel.text = "Roll: "
            DheadingLabel.text = "Heading: "
            DlocationLabel.text = "Lat: , Long:"
            
            
            DyawLabel.textColor = DebugColor
            DpitchLabel.textColor = DebugColor
            DrollLabel.textColor = DebugColor
            DheadingLabel.textColor = DebugColor
            DlocationLabel.textColor = DebugColor
            
            halfInfiniteWall2.backgroundColor = UIColor.red
            halfInfiniteWall2.alpha = 0.5
            
            halfInfiniteWall1.backgroundColor = UIColor.blue
            halfInfiniteWall1.alpha = 0.5
            
            self.addSubview(DyawLabel)
            self.addSubview(DrollLabel)
            self.addSubview(DpitchLabel)
            self.addSubview(DheadingLabel)
            self.addSubview(DlocationLabel)
        }
        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let hed = CGFloat(newHeading.magneticHeading)
        
        
        
        
        //Position Écrans rouge
        if (hed > 180){
            halfInfiniteWall2.frame.origin.x = halfInfiniteWall1.frame.width  * (hed - 180) / (-180)
            
        }
        else{
            halfInfiniteWall2.frame.origin.x = halfInfiniteWall1.frame.width  * (180 - hed) / (180)
        }
        //Posititon Écrans bleu
        if (hed <= 180) {
            halfInfiniteWall1.frame.origin.x = halfInfiniteWall1.frame.width * ( hed  / -180)
        }
        else{
            halfInfiniteWall1.frame.origin.x = halfInfiniteWall1.frame.width * ((360 - hed ) / 180)
        }
        
        if DEBUG {
            DheadingLabel.text = "Heading: \(newHeading.magneticHeading)"
        }
    }
    
    func placePointOnWall(view: UIView, degree: CGFloat) {
        if (degree >= 180 && degree <= 0) {
            view.frame = CGRect(x: CGFloat(degree/180)*halfInfiniteWall1.frame.width - 30, y: self.frame.height/2 - 30, width: 60, height: 60)
            halfInfiniteWall1.addSubview(view)
        } else {
            view.frame = CGRect(x: CGFloat((degree-180)/180)*halfInfiniteWall2.frame.width - 30, y: self.frame.height/2 - 30, width: 60, height: 60)
            halfInfiniteWall2.addSubview(view)
        }
    }
    
    func addLocationToView(toAdd: CLLocationCoordinate2D) {
        let distance = calculateDistance(origin: self.location, destination: toAdd)
        let bearing = calculateBearing(origin: self.location, destination: toAdd)
        
        var view = UIView()
        view.backgroundColor = UIColor.orange
        
        
        if (bearing >= 180 && bearing <= 0) {
            view.frame = CGRect(x: CGFloat(bearing/180)*halfInfiniteWall1.frame.width - 30, y: self.frame.height/2 - 30, width: 60, height: 60)
            halfInfiniteWall1.addSubview(view)
        } else {
            view.frame = CGRect(x: CGFloat((bearing-180)/180)*halfInfiniteWall2.frame.width - 30, y: self.frame.height/2 - 30, width: 60, height: 60)
            halfInfiniteWall2.addSubview(view)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMotion() {
        if (self.motionManager.deviceMotion?.attitude.quaternion) != nil {
            let quat = self.motionManager.deviceMotion!.attitude.quaternion
            let Roll = radToDeg(rad: atan2(2*(quat.y*quat.w - quat.x*quat.z), 1 - 2*quat.y*quat.y - 2*quat.z*quat.z))
            let Pitch = radToDeg(rad: atan2(2*(quat.x*quat.w + quat.y*quat.z), 1 - 2*quat.x*quat.x - 2*quat.z*quat.z))
            let Yaw = radToDeg(rad: asin(2*quat.x*quat.y + 2*quat.w*quat.z))
            
            if DEBUG {
                DyawLabel.text = "Yaw: \(Yaw + 180)"
                DpitchLabel.text = "Pitch: \(Pitch + 180)"
                DrollLabel.text = "Roll: \(Roll + 180)"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if DEBUG {
            DlocationLabel.text = "Lat: \(locations[0].coordinate.latitude), Long: \(locations[0].coordinate.longitude)"
        }
        self.location = locations[0].coordinate
    }
    
    func radToDeg(rad: Double) -> Double {
        return (180/M_PI)*rad
    }
    
    func calculateDistance(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> Double {
        return CLLocation(latitude: origin.longitude, longitude: origin.longitude).distance(from: CLLocation(latitude: destination.latitude, longitude: destination.longitude))
    }
    
    func calculateBearing(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> Double {
        let x = origin.longitude - destination.longitude
        let y = origin.latitude - destination.latitude
        
        return fmod(radToDeg(rad: atan2(y, x)), 360.0) + 90.0
    }
    
    
    func beginCameraSession() {
        do {
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.layer.insertSublayer(previewLayer!, at: 0)
            previewLayer?.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight)
            captureSession.startRunning()
        } catch {
            print("Cannot start Camera")
        }
    }
    
}
