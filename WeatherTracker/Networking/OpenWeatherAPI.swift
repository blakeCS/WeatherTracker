//
//  OpenWeatherAPI.swift
//  WeatherTracker
//
//  Created by Madeline Burton on 6/29/22.
//

import Foundation

//STEP TWO: Prep API URL

extension API{
    
    static let baseURLString = "https://api.openweathermap.org/data/3.0/"
    
    // Get the full API request URL using a latitude and longitude
    static func getLocationURL(lat: Double, lon: Double) -> String {
        return "\(baseURLString)oncall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=imperial"
    }
}
