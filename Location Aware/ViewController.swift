//
//  ViewController.swift
//  Location Aware
//
//  Created by Karim Khalifa on 6/9/18.
//  Copyright © 2018 Karim Khalifa. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation : CLLocation = locations[0]
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil{
                print(error)
            }
            else{
                if let placemark = placemarks?[0]{
                    
                    var subThoroughFare = ""
                    if placemark.subThoroughfare != nil{
                        subThoroughFare = placemark.subThoroughfare!
                    }
                    
                    var thoroughFare = ""
                    if placemark.thoroughfare != nil && placemark.thoroughfare != "Infinite Loop"{
                        thoroughFare = placemark.thoroughfare!
                    }
                    
                    var subLocality = ""
                    if placemark.subLocality != nil{
                        subLocality = placemark.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil{
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    
                    var postalCode = ""
                    if placemark.postalCode != nil{
                        postalCode = placemark.postalCode!
                    }
                    
                    var country = ""
                    if placemark.country != nil{
                        country = placemark.country!
                    }
                    
                    
                    
                    self.latLabel.text = String(userLocation.coordinate.latitude)
                    self.longLabel.text = String(userLocation.coordinate.longitude)
                    self.courseLabel.text = String(userLocation.course)
                    self.speedLabel.text = String(userLocation.speed)
                    self.altLabel.text = String(userLocation.altitude)
                    self.addLabel.text = subThoroughFare + "\n" + thoroughFare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country
                    
                    //let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    //let region:MKCoordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
                    //self.map.setRegion(region, animated: true)
                    let tracking:MKUserTrackingMode = MKUserTrackingMode(rawValue: 1)!
                    self.map.setUserTrackingMode(tracking, animated: true)
                    
                }
            }
        }
        
    }

}

