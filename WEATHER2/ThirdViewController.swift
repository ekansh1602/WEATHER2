//
//  ThirdViewController.swift
//  WEATHER2
//
//  Created by Ekansh Anand Srivastava on 12/12/18.
//  Copyright © 2018 Avi Srivastava. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ThirdViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapview: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
    }
    
    
    var locationmanager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userlocation : CLLocation = locations[0]
        let latitude = userlocation.coordinate.latitude
        let longitude = userlocation.coordinate.longitude
        let latideltazoom : CLLocationDegrees = 0.05
        let longideltazoom : CLLocationDegrees = 0.05
        let span :  MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latideltazoom, longitudeDelta: longideltazoom)
        let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotations = MKPointAnnotation()
        annotations.title = "USER'S LOCATION"
        annotations.coordinate = coordinate
        mapview.addAnnotation(annotations)
        
        mapview.setRegion(region, animated: true)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
}
    //SEGUE FROM VIEWCONTROLLERTHREE TO VIEWCONTROLLERTWO
    @IBAction func rewindback(_ sender: Any) {
        performSegue(withIdentifier: "four", sender: self)
    }
}
