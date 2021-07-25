//
//  Manager.swift
//  Weather
//
//  Created by MacBook on 24.07.2021.
//

// !!Check all of func on mutating mode, cause JSON is not working with it

import Foundation

struct Manager {
    
 
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
                self.parseJSON(weatherData: safeData)
            }
        }
        
        // start the task (Resumes the task, if it is suspended)
        dataTask.resume()
        
        
        
    }
    // create func to parse JSON to get needed data
    // interaction with WeatherData struct with Decodable protocol
    func parseJSON(weatherData: Data) {
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
            
            let weatherModel = WeatherModel(cityName: name, condition: id, temperature: temp)
            
            print(weatherModel.weatherCondition)
            
            
        } catch {
            print(error)
        }
   
    }
    
    
}
