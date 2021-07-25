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
        // set delegate to adress to UITextFieldDelegate protocol
        searchTextField.delegate = self
        
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

