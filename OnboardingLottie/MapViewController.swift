//
//  MapViewController.swift
//  MotionEffect
//
//  Created by Sai Raghu Varma Kallepalli on 2/11/19.
//  Copyright © 2019 Training. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DatabaseListener {
    
    var speed: String!

    @IBOutlet weak var speedHeading: UILabel!
    @IBOutlet weak var LimitHeading: UILabel!
    @IBOutlet weak var currentHeading: UILabel!
    //speedLimitLabel
    @IBOutlet weak var speedLimitLabel: UILabel!
    //mapView
    @IBOutlet weak var mapView: MKMapView!
    //userSpeedImg
    @IBOutlet weak var userSpeedImg: UIImageView!
    //speedLimitImg
    @IBOutlet weak var speedLimitImg: UIImageView!
    @IBOutlet weak var currentSpeedLabel: UILabel!
    //speedLimitBgImage
    @IBOutlet weak var speedLimitAndLabelBg: UIImageView!
    @IBOutlet weak var streetLabel: UILabel!
    
    
    weak var databaseController: DatabaseProtocol?
    var dataList: [Sensor] = [Sensor]()

    
    var locationMgr: CLLocationManager = CLLocationManager()
    //If location is not determined, then map foucs towards city
    var focusLocation = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: -37.815338, longitude: 144.963226), 2500, 2500)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate!.databaseController
        createSpeedCircles()
        mapKitInitializers()
        
    }
    
    var listenerType = ListenerType.data

    func onDataListChange(change: DatabaseChange, dataList: [Sensor]) {
        self.dataList = dataList
        //updateSppedLimit(latitude: dataList[0].gps.curLat, longitude: dataList[0].gps.curLong)
        calculateSpeed(data: dataList)
        focusLocation = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: dataList[0].gps.curLat, longitude: dataList[0].gps.curLong), 50, 50)
        let cam = MKMapCamera()
        cam.centerCoordinate = CLLocationCoordinate2D(latitude: dataList[0].gps.curLat, longitude: dataList[0].gps.curLong)
        cam.pitch = 80
        cam.altitude = 100
        cam.heading = 0
        mapView.setRegion(focusLocation, animated: true)
        mapView.setCamera(cam, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        databaseController?.addListener(listener: self)
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        databaseController?.removeListener(listener: self)
    }
    
    func mapKitInitializers() {
        mapView.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationMgr.distanceFilter = 10
        locationMgr.delegate = self
        locationMgr.startUpdatingHeading()
        locationMgr.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        mapView.setRegion(focusLocation, animated: true)
        locationMgr.startUpdatingLocation()
    }
    
    func createSpeedCircles()
    {
        let y: CGFloat = -95
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 2, animations: {
                self.speedLimitAndLabelBg.transform = CGAffineTransform(translationX: 0, y: y)
                self.speedHeading.transform = CGAffineTransform(translationX: 0, y: y)
                self.LimitHeading.transform = CGAffineTransform(translationX: 0, y: y)
                self.currentHeading.transform = CGAffineTransform(translationX: 0, y: y)
                self.speedLimitLabel.transform = CGAffineTransform(translationX: 0, y: y)
                self.streetLabel.transform = CGAffineTransform(translationX: 0, y: y)
                self.currentSpeedLabel.transform = CGAffineTransform(translationX: 0, y: y)
                self.userSpeedImg.transform = CGAffineTransform(translationX: 0, y: y)
                self.speedLimitImg.transform = CGAffineTransform(translationX: 0, y: y)
                self.userSpeedImg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.userSpeedImg.layer.cornerRadius = (self.userSpeedImg.frame.size.width)/2
                self.userSpeedImg.layer.borderWidth = 7
                self.userSpeedImg.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                self.userSpeedImg.clipsToBounds = true
                self.speedLimitImg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.speedLimitImg.layer.cornerRadius = (self.speedLimitImg.frame.size.width)/2
                self.speedLimitImg.layer.borderWidth = 7
                self.speedLimitImg.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                self.speedLimitImg.clipsToBounds = true
            })
            UIView.animate(withDuration: 1, animations: {
                //self.speedLimitBgImage.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                self.speedLimitAndLabelBg.layer.cornerRadius = (self.speedLimitAndLabelBg.frame.size.width)/10
                self.speedLimitAndLabelBg.layer.borderWidth = 2
                self.speedLimitAndLabelBg.layer.borderColor = #colorLiteral(red: 0.1606533527, green: 0.1661810279, blue: 0.1873781979, alpha: 1)
                self.speedLimitAndLabelBg.clipsToBounds = true
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        mapView.camera.heading = newHeading.magneticHeading
        //mapView.setCamera(mapView.camera, animated: true)
    }
    
    //Updates location coordinates
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location: CLLocation = locations.last!
//
//        //updateSppedLimit(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//
//        focusLocation = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), 50, 50)
//        let cam = MKMapCamera()
//        cam.centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        cam.pitch = 80
//        cam.altitude = 100
//        cam.heading = 0
//        mapView.setRegion(focusLocation, animated: true)
//        mapView.setCamera(cam, animated: true)
////        UIView.animate(withDuration: 1, animations: {
////            //self.speedLimitLabel.text = self.speed
////            self.speedLimitLabel.transform = CGAffineTransform(translationX: +7, y: 0)
////        })
//
//
//    }
    
    func updateSppedLimit(latitude: Double, longitude: Double)
    {
        let lat = String(format: "%f", latitude)
        let lon = String(format: "%f", longitude)
        
        let url = URL(string: "https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?prox=" + lat + "," + lon + ",50&mode=retrieveAddresses&locationAttributes=linkInfo&gen=9&app_id=bGsxRlcLJl9jlkPw8llT&app_code=P61HIba-X4DxDhv2SypcFg")
        
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            if let data = data {
                let resp = try? JSONDecoder().decode(JsonResponse.self, from: data)
                self.speed = (resp?.Response.View.first?.Result.first?.Location.LinkInfo.SpeedCategory)!
                print(resp)
                print(self.speed!)
                print("Speed retrieved")
                DispatchQueue.main.async {
                    self.displaySpeedLimit()
                    self.setStreetLabel(resp: resp!)
                }
            }
        }.resume()
        
//        if speed == "SC1"{
//            print(">130")
//            speedLimitLabel.text = ">130"
//        }
//        else if speed == "SC2"{
//            print("130")
//            speedLimitLabel.text = "130"
//        }
//        else if speed == "SC3"{
//            print("100")
//            speedLimitLabel.text = "100"
//        }
//        else if speed == "SC4"{
//            print("90")
//            speedLimitLabel.text = "90"
//            UIView.animate(withDuration: 1, animations: {
//                self.speedLimitLabel.text = "90"
//                self.speedLimitLabel.transform = CGAffineTransform(translationX: +7, y: 0)
//            })
//        }
//        else if speed == "SC5"{
//            print("70")
//            speedLimitLabel.text = "70"
//        }
//        else if speed == "SC6"{
//            print("50")
//            speedLimitLabel.text = "50"
//        }
//        else if speed == "SC7"{
//            print("30")
//            speedLimitLabel.text = "30"
//        }
//        else if speed == "SC8"{
//            print("<11")
//            speedLimitLabel.text = "<11"
//        }
    }
    
    func displaySpeedLimit() {
        if speed == "SC1"{
            print(">130")
            speedLimitLabel.text = ">130"
        }
        else if speed == "SC2"{
            print("130")
            speedLimitLabel.text = "130"
        }
        else if speed == "SC3"{
            print("100")
            speedLimitLabel.text = "100"
        }
        else if speed == "SC4"{
            print("90")
            speedLimitLabel.text = "90"
        }
        else if speed == "SC5"{
            print("70")
            speedLimitLabel.text = "70"
        }
        else if speed == "SC6"{
            print("50")
            speedLimitLabel.text = "50"
        }
        else if speed == "SC7"{
            print("30")
            speedLimitLabel.text = "30"
        }
        else if speed == "SC8"{
            print("<11")
            speedLimitLabel.text = "<11"
        }
    }
    
    func setStreetLabel(resp: JsonResponse){
        if((resp.Response.View.first?.Result.first?.Location.Address.Street!.isEmpty)!){
            self.streetLabel.text = resp.Response.View.first?.Result.first?.Location.Address.District
        }
        else{
            print(resp.Response.View.first?.Result.first?.Location.Address.Street!)
            self.streetLabel.text = resp.Response.View.first?.Result.first?.Location.Address.Street
        }
    }
    
    func calculateSpeed(data: [Sensor])
    {
        if(data[0].gps.prevLat == 0 )
        {
            return
        }
        else
        {
            let coordinate1 = CLLocation(latitude: data[0].gps.curLat, longitude: data[0].gps.curLong)
            let coordinate2 = CLLocation(latitude: data[0].gps.prevLat, longitude: data[0].gps.prevLong)

            let distanceInMeters = coordinate1.distance(from: coordinate2)
            let timeDiff = data[0].gps.curTime - data[0].gps.prevTime
            let speedKph: Int = Int((Double(distanceInMeters) / Double(timeDiff)) * ( 3.6 ))
            self.currentSpeedLabel.text = String(speedKph)
            
            
        }
        
    }
    
}

