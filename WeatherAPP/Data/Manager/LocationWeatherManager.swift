//
//  LocationWeatherManager.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodingError
}

class LocationWeatherManager {
    
    static let shared = LocationWeatherManager()
    private var lang: String = Locale.current.language.languageCode?.identifier ?? ""
    init() {}
 
    func getCurrentWeather(lat:Double,lon:Double,completion: @escaping (Result<CurrentWeather,NetworkError>) -> Void) {
        LoadingIndicator.shared.show()
        guard let url = URL(string: "\(APPConstants.baseURL)data/2.5/weather?lat=\(lat)&lon=\(lon)&lang=\(lang)&units=imperial&appid=\(APPConstants.appKey)") else {
            LoadingIndicator.shared.hide()
            completion(.failure(.serverError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                LoadingIndicator.shared.hide()
                completion(.failure(.serverError))
                return
            }
            do {
                let weather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                LoadingIndicator.shared.hide()
                completion(.success(weather))
            } catch {
                LoadingIndicator.shared.hide()
                completion(.failure(.decodingError))
            }
        }.resume()
 
    }
    
    func getDailyWeather(lat:Double,lon:Double, completion: @escaping (Result<DailyWeather,NetworkError>) -> ()) {
        LoadingIndicator.shared.show()
        guard let url = URL(string: "\(APPConstants.baseURL)data/2.5/onecall?lat=\(lat)&lon=\(lon)&lang=\(lang)&exclude=minutely&units=imperial&appid=\(APPConstants.appKey)") else {
            LoadingIndicator.shared.hide()
            completion(.failure(.serverError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                LoadingIndicator.shared.hide()
                completion(.failure(.serverError))
                return
            }
            do {
                let weather = try JSONDecoder().decode(DailyWeather.self, from: data)
                LoadingIndicator.shared.hide()
                completion(.success(weather))
            } catch {
                LoadingIndicator.shared.hide()
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}
