//
//  WeatherData.swift
//  Weather
//
//  Created by MacBook on 25.07.2021.
//

import Foundation

// set a struct with Codable protocol to refer to openweathermap data
// (A type that can decode itself from an external representation)
struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    
    
}
// added Main struct to get temp in main object in api.openweathermap.org
struct Main: Codable {
    let temp: Float
}
// added Main struct to get id in main object in api.openweathermap.org
struct Weather: Codable {
    let id: Int
}

