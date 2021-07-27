//
//  WeatherModel.swift
//  Weather
//
//  Created by MacBook on 25.07.2021.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let condition: Int
    let temperature: Float
    
    // created computed property temp to convert Float to String
    var temp: String {
        return String(format: "%.0f", temperature)
    }

    
    // created computed property (instead of func to deal with switch statement):
    var weatherCondition: String {
        
        switch condition {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "smoke"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
            
        }
    }
  
    
    
}
