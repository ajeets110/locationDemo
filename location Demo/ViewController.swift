//
//  ViewController.swift
//  location Demo
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {

    // create a variable of CLLocationManager
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // grabbing the user's location
        let userLocation: CLLocation = locations[0]
        
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        
        let latDelta : CLLocationDegrees = 0.05
        let longDelta : CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        //print(userLocation)
        
        // finding the user address from the user's location
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let error = error {
                print(error)
            } else {
                if let placemark = placemarks?[0] {
                    var subThoroufare = ""
                    if placemark.subThoroughfare != nil {
                        subThoroufare = placemark.subThoroughfare!
                    }
                    var thoroufare = ""
                    if placemark.thoroughfare != nil {
                        thoroufare = placemark.thoroughfare!
                    }
                    var subLocality = ""
                    if placemark.subLocality != nil{
                        subLocality = placemark.subLocality!
                        
                    }
                    var administrativeArea = ""
                    if placemark.administrativeArea != nil
                    {
                        administrativeArea = placemark.administrativeArea!
                    }
                    var country = ""
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    print(subThoroufare + thoroufare + "\n" + subLocality + "\n" + administrativeArea + "\n" + country)
                }
            }
        }
    }

}

