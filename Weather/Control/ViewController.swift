//
//  ViewController.swift
//  Weather
//
//  Created by MacBook on 23.07.2021.
//

import UIKit
// to import CoreLocation to get location data
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    // initializated CLLocationManager class to get location data
    // after that: go to info.plist and set Localization to "Privacy Location when in use Usage Description"
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var widgetImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegated location manager (!always the first in viewDid)
        locationManager.delegate = self
        
        //triggered permission request: when user use app
        locationManager.requestWhenInUseAuthorization()
        
        // add one time request user location
        // if you need to get user location constantly sett func: startUpdatingLocation()
        locationManager.requestLocation()
        
        
        
        //check out how new icons work
        widgetImage.image = UIImage(systemName: "cloud.moon.rain")
        // set delegate to adress to UITextFieldDelegate protocol
        searchTextField.delegate = self
        // delegation from Manager activated
        weatherManager.managerDelegate = self
        
    }

    
    @IBAction func locationButton(_ sender: UIButton) {
        // activated location request when button pressed
        locationManager.requestLocation()
        // hide keyboard when stepper pressed
        searchTextField.endEditing(true)
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        // hide keyboard when stepper pressed
        searchTextField.endEditing(true)
        
    }
    
    

}
// extension to get access to functions in UITextFieldDelegate protocol
// directly relayted to delegate in viewdidload
extension ViewController: UITextFieldDelegate {
    
    // trigger func when Return button pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard when stepper pressed
        searchTextField.endEditing(true)
        return true
    }
    // trigger func make user something type
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type a city name"
            return false
        }
    }
    
    
    // trigger func when user end editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let city = textField.text else {
            return
        }
        // transfer city name to func fullUrlName in Manager struct
        weatherManager.fullUrlName(city)
        

        // to clear text in textTield
        searchTextField.text = ""
        
    }
    

}
// extension to receive weather information delegated from Manager struct
extension ViewController: ManagerDelegate {

    func didUpdateWeather(_ weather: WeatherModel) {

        // to avoid crush and error like "... must be used from main thread only"
        // to avoid frozen app state use Dispatch Queue
        // added self cause it's in closure
        DispatchQueue.main.async {
            
            // added data from Manager struct by WeatherModel struct to show them on the screen
            self.temperatureLabel.text = weather.temp
            self.cityLabel.text = weather.cityName
            self.widgetImage.image = UIImage(systemName: weather.weatherCondition)
            
        }
    }
    
    
}
// extension for CLLocationManagerDelegate protocol to get user location
extension ViewController: CLLocationManagerDelegate {
        // defauult apple's function to get user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //unwrapping last user location
        if let location = locations.last {
            // The radius of uncertainty for the location, measured in meters
            if location.horizontalAccuracy > 0 {
                // stop location process when user was located
                locationManager.stopUpdatingLocation()
                
                let lon = Float(location.coordinate.longitude)
                let lat = Float(location.coordinate.latitude)
                
                // dispatched coordinates to WeatherManager
                weatherManager.getLocation(lat, lon)
                
            }
        }
    }
    // default apple's func is needed if location update failed (avoid frozen app)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location update failed, \(error) ")
    }
}

