//
//  WeatherModel.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation

class WeatherModel {
    
    var lat: Double?
    var lon: Double?
    var currentWeather: CurrentWeather?
    var dailyWeather: DailyWeather?
    
    private let group = DispatchGroup()
    
    func withGeolocationWeather(completion: @escaping () -> ()) {
        guard let latitudeValue = lat, let longitudeValue = lon else {
            return
        }
        group.enter()
            LocationWeatherManager.shared.getCurrentWeather(lat: latitudeValue, lon: longitudeValue) { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.currentWeather = weather
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
            LocationWeatherManager.shared.getDailyWeather(lat: latitudeValue, lon: longitudeValue) { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.dailyWeather = weather
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.group.leave()
            }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func noGeolocationWeather(completion: @escaping () -> ()) {
        group.enter()
            NoLocationWeatherManager.shared.getCurrentWeather() { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.currentWeather = weather
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.group.leave()
            }
        
        group.enter()
            NoLocationWeatherManager.shared.getDailyWeather() { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.dailyWeather = weather
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.group.leave()
            }
            
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    
    func saveLastCity(lat:Double, lan:Double){
        let locationData = ["lat":lat,
                            "lon":lon]
        UserDefaults.standard.set(locationData, forKey: "cityData")
    }
    
    func fetchSavedLastCity(compelition: @escaping ([String:Double]) -> ()){
        if let data = UserDefaults.standard.dictionary(forKey: "cityData") as? [String:Double] {
             compelition(data)
        }
    }
    
    
} 
