//
//  CurrentViewModel.swift
//  WeatherTracker
//
//  Created by Madeline Burton on 6/29/22.
//

import Foundation
import CoreLocation


final class CurrentViewModel{
    
    // When a property marked @Published is changed, all views using this property
    // will refresh when it is updeated
    @Published var weather = WeatherResponse.template()
    
    @Published var city = "New York" {
        didSet {
            getLocation()
            print(weather.current.weather[0].icon)
        }
    }
    
    
    // Format Time Values
    
    // Lazy variables are not initialized until they are first called
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
     
    init(){
        getLocation()
    }
    
    // Populate the correct date
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    // Populate the correct icon
    var weatherIcon: String {
        // Check if the weather count is greater than 0
        // This could occur before it first loads
        if weather.current.weather.count > 0{
            return weather.current.weather[0].icon
        }
        // If no data, make it sunny!
        return "sun.max.fill"
    }
    
    // Store the new temperature in the variable temp using helper function (below)
    var temp: String {
        return getTemp(temp: weather.current.temp)
    }
    
    
    var conditions: String {
        if weather.current.weather.count > 0{
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    
    // Formatting helper functions
    func getTemp(temp:Double) -> String{
        return String(format: "%0.1f", temp)
    }
    
    func getTime(timestamp: Int) -> String{
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getDay(timestamp: Int) -> String{
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    // Get the data for a particular location
    private func getLocation(){
        CLGeocoder().geocodeAddressString(city) {(placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(loc: place.location?.coordinate)
            }
            
        }
    }
    
    
    
    // Get the weather data for a location
    private func getWeather(loc: CLLocationCoordinate2D?){
        var urlString = ""
        
        if let loc = loc{
            urlString = API.getLocationURL(lat: loc.latitude, lon: loc.longitude)
        } else {
            urlString = API.getLocationURL(lat: 40.712, lon: 74.0060)
        }
        print(urlString)
        
        // Make the network call
        NetworkManager<WeatherResponse>.retrieveData(for: URL(string: urlString)!) { (result) in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.weather = data
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    // Get Animations from Lottie - GIVE THIS TO STUDENTS??
    // Switch statement made from here: https://openweathermap.org/weather-conditions
    func getLottieAnim(icon: String) -> String {
        switch icon {
            case "01d": return "dClearSky"
            case "02d": return "dFewClouds"
            case "03d": return "dScatteredClouds"
            case "04d": return "dBrokenClouds"
            case "09d": return "dShowerRain"
            case "10d": return "dRain"
            case "11d": return "dThunderstorm"
            case "13d": return "dSnow"
            case "15d": return "dMist"
            case "01n": return "nClearSky"
            case "02n": return "nFewClouds"
            case "03n": return "nScatteredClouds"
            case "04n": return "nBrokenClouds"
            case "09n": return "nShowerRain"
            case "10n": return "nRain"
            case "11n": return "nThunderstorm"
            case "13n": return "nSnow"
            case "15n": return "nMist"
        default:
            return "dClearSky"
        }
    }
    
    
}
