//
//  Manager.swift
//  Weather
//
//  Created by MacBook on 24.07.2021.
//

// !!Check all of func on mutating mode, cause JSON is not working with it

import Foundation

// added protocol to delegate data from row 62 to ViewController
protocol ManagerDelegate {
    
    func didUpdateWeather(_ weather: WeatherModel)
}

struct Manager {
    
    // initialization a protocol in Manager struct
    var managerDelegate: ManagerDelegate?
 
    // set url from api.openweathermap.org without cityname
    let openweathermapUrl = "https://api.openweathermap.org/data/2.5/weather?appid=158ad76558d0df40e3b310c6152d85ce&units=metric"
    
    func fullUrlName(_ cityName: String) {
        
        let openweathermapUrlPlusCityName = "\(openweathermapUrl)&q=\(cityName)"
        performRequest(urlString: openweathermapUrlPlusCityName)
    }
    
    func performRequest(urlString: String) {
        
        // trigger struct URL to pass openweathermap URL with city name
        // unwrapping url to proceed further
        guard let url = URL(string: urlString) else {
            return
        }
        // create URL session, and pass url to session
        let session = URLSession(configuration: .default)
        
        // give a session a data task
        // set a closure to unwrap all off completionHandler data, interaction with dataTask
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            // unwraping error, and way out if error happens
            if error != nil {
                print(error ?? "error in handle method")
                return // set return to way out from handle method
            }
            // unwrapping data to convert Data to String further
            if let safeData = data {
                
                // to return information from parseJSON, created let weather:
                // 1) added let weather
                // 4) unwrapping let weather because we added WeatherModel? struct before
                
                guard let weather = self.parseJSON(safeData) else {
                    return
                }
                
                // set delegate to dispatch wheater information to ViewController
                // should to put self before delegation, because this line exist in closure
                self.managerDelegate?.didUpdateWeather(weather)
                
            }
        }
        
        // start the task (Resumes the task, if it is suspended)
        dataTask.resume()
        
        
        
    }
    // create func to parse JSON to get needed data
    // interaction with WeatherData struct with Decodable protocol
    // 2) added output optional WeatherModel? struct to return itself
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        // initialized decoder from JSONDecoder class
        let decoder = JSONDecoder()
        // interact with Decodable WeatherData struct
        do {
            // assign WeatherData struct to let decodedData to get needed data
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            // get data from api.openweathermap.org via WeatherData
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            // added weatherModel to dispatch received data above to WeatherModel struct
            let weatherModel = WeatherModel(cityName: name, condition: id, temperature: temp)
            // 3) added return weatherModel to avoid error
            return weatherModel
            
 
            
            
        } catch {
            print(error)
            return nil
        }
   
    }
    
    
}
