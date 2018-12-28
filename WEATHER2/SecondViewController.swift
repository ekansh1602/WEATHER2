//
//  SecondViewController.swift
//  WEATHER2
//
//  Created by Ekansh Anand Srivastava on 12/12/18.
//  Copyright © 2018 Avi Srivastava. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class SecondViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
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
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        fetchCityAndCountry(from: location){
            city, country, error in
            guard let city = city, let country = country, error == nil else{
                return
            }
            
            print(city)
            //CODE TO GET THE WEATHER DATA
            if let url = URL(string: "https://www.weather-forecast.com/locations/\(city)/forecasts/latest"){
                let request = NSMutableURLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if (error != nil) {
                        print(error!)
                    }
                    else{
                        if let unwrappedData = data{
                            let dataString  = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                           // print(dataString)
                            
                            
                            var stringSeparator = "Kanpur Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                            if let contentarray = dataString?.components(separatedBy: stringSeparator){
                                
                                if contentarray.count>0{
                                    stringSeparator = "</span>"
                                    
                                    let newContentarray = contentarray[0].components(separatedBy: stringSeparator)
                                    
                                    if newContentarray.count>0{
                                        print(newContentarray[0])
                                    }
                                }

                            }
                            
                            DispatchQueue.main.sync(execute: {
                                
                                
                                //UPDATE USER INTERFACE
                                
                                
                            })
                            
                            
                        }
                    }
                }
                
                task.resume()
            }
            
        }
        
        
        
    } //LAST CURLY BRACE OF FUNCTION DIDUPDATELOCATION
    
    //FUNCTION TO GIVE CITY NAME
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }


    

    
    
    
//SEGUE FROM VIEWCONTROLLERONE TO VIEWCONTROLLERTWO
    


    @IBAction func search(_ sender: Any) {
        performSegue(withIdentifier: "one", sender: self)
    }
    
    

//SEGUE FROM VIEWCONTROLLERONE TO VIEWCONTROLLERTHREE
    
    @IBAction func showmaps(_ sender: Any) {
        performSegue(withIdentifier: "three", sender: self)
    }
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //LAST CURLY BRACES OF THE CLASS
