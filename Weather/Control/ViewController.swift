//
//  ViewController.swift
//  Weather
//
//  Created by MacBook on 23.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var manager = Manager()

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var widgetImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //check out how new icons work
        widgetImage.image = UIImage(systemName: "cloud.moon.rain")
        // set delegate to adress to UITextFieldDelegate protocol
        searchTextField.delegate = self
        // delegation from Manager activated
        manager.managerDelegate = self
        
    }

    
    @IBAction func locationButton(_ sender: UIButton) {
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
        manager.fullUrlName(city)
        

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

