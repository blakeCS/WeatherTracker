//
//  WeatherResponse.swift
//  WeatherTracker
//
//  Created by Madeline Burton on 6/29/22.
//

import Foundation

// 4. Create the full weather response
struct WeatherResponse: Codable{
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    
    // Create an object with no data using the initializers - this will avoid shrinking/collapsing views as data loads
    // Use repeating to make a total of 23 future hours (for the day)
    // Use repeating to make a total of 8 days
    static func template() -> WeatherResponse{
        return WeatherResponse (current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
    
}


// 1. Create the most detailed view
// Codable requires it to conform to the JSON decoding scheme
struct WeatherDetail: Codable{
    var main: String
    var description: String
    var icon: String
}



// 2. Create the general weather, which relies on weather deatil
struct Weather: Codable, Identifiable {
    var dt: Int
    var temp: Double
    var feel_like: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var clouds: Int
    var wind_speed: Double
    var wind_deg: Int
    // WeatherDetail comes back ans an array, which is why we have this object
    var weather: [WeatherDetail]
    
    
    // OPTIONAL: create var names that are different from the JSON
    enum CodingKey: String{
        case date = "dt"
        case temperature = "temp"
        case feelsLike = "feel_like"
        case pressure
        case humidity
        case dew_point
        case numClouds = "clouds"
        case wind_speed
        case wind_deg
        case weather
    }
    
    // Initialize all values
    init() {
        dt = 0
        temp = 0.0
        feel_like = 0.0
        pressure = 0
        humidity = 0
        dew_point = 0.0
        clouds = 0
        wind_speed = 0.0
        wind_deg = 0
        weather = []
    }

}

// Created separately so that it is not part of the codable
extension Weather {
    var id: UUID{
        return UUID()
    }
}

// 3. Create a temperature struct
struct Temperature: Codable{
    var min: Double
    var max: Double
}

// 3. Create a data structure for the daily weather
struct DailyWeather: Codable, Identifiable{
    var dt: Int
    var temp: Temperature
    var weather: [WeatherDetail]
    
    enum CodingKey: String{
        case dt
        case temp
        case weather
    }
    
    init(){
        dt = 0
        temp = Temperature(min:0.0, max: 0.0)
        weather = [WeatherDetail(main:"", description:"", icon: "")]
    }
}

// Created separately so that it is not part of the codable
extension DailyWeather {
    var id: UUID{
        return UUID()
    }
}
