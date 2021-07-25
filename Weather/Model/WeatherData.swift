//
//  WeatherData.swift
//  Weather
//
//  Created by MacBook on 25.07.2021.
//

import Foundation

// set a struct with Decodable protocol to refer to openweathermap data
// (A type that can decode itself from an external representation)
struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    
    
}
// added Main struct to get temp in main object in api.openweathermap.org
struct Main: Decodable {
    let temp: Float
}
// added Main struct to get id in main object in api.openweathermap.org
struct Weather: Decodable {
    let id: Int
}

