//
//  ViewController.swift
//  WEATHER2
//
//  Created by Ekansh Anand Srivastava on 12/12/18.
//  Copyright © 2018 Avi Srivastava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var city: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        let s = city.text!
        var s1 = s.components(separatedBy: " ")
        let c = s1.count
        print(c)
        if(c==1){
        getweather()
        }
        else if(c==2){
        getWeather2()
        }

    }
    


    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func getweather(){
        
            if let url = URL(string: "https://www.weather-forecast.com/locations/\(city.text!)/forecasts/latest"){
                let request = NSMutableURLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if (error != nil) {
                        print(error!)
                    }
                    else{
                        if let unwrappedData = data{
                            let dataString  = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                            //print(dataString)
                            
                            var stringSeparator = "Kanpur Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                            if let contentarray = dataString?.components(separatedBy: stringSeparator){
                                
                                if contentarray.count>0{
                                    stringSeparator = "</span>"
                                    
                                    let newContentarray = contentarray[1].components(separatedBy: stringSeparator)
                                    
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
    
    
    
    func getWeather2(){ //WORKING ONLY FOR NAMES WITH TWO WORDS EXACTLY
        
        let s = city.text!
        var s1 = s.components(separatedBy: " ")
        let s2 = s1[0]+"-"+s1[1]
        
        
        
        
        
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/\(s2)/forecasts/latest"){
            let request = NSMutableURLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if (error != nil) {
                    print(error!)
                }
                else{
                    if let unwrappedData = data{
                        let dataString  = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        print(dataString)
                        
                        DispatchQueue.main.sync(execute: {
                            
                            
                            //UPDATE USER INTERFACE
                            
                            
                        })
                        
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
    //BACKSEGUE FROM VIEWCONTROLLER2 TO VIEWCONTROLLER1
    
    @IBAction func backsegue(_ sender: Any) {
        performSegue(withIdentifier: "two", sender: self)
    }
    

    } //LAST CURLY BRACES OF THE CLASS

