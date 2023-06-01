//
//  NoLocationWeatherManager.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation

class NoLocationWeatherManager {
    
    static let shared = NoLocationWeatherManager()
    private var lang: String = Locale.current.language.languageCode?.identifier ?? ""
    
    private init() {}
 
    func getCurrentWeather(completion: @escaping (Result<CurrentWeather,NetworkError>) -> Void) {
        LoadingIndicator.shared.show()
        guard let url = URL(string: "\(APPConstants.baseURL)data/2.5/weather?lat=12.9258023&lon=77.6860099&lang=\(lang)&units=metric&appid=\(APPConstants.appKey)") else {
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
    
    func getDailyWeather(completion: @escaping (Result<DailyWeather,NetworkError>) -> Void) {
        LoadingIndicator.shared.show()
        guard let url = URL(string: "\(APPConstants.baseURL)data/2.5/onecall?lat=12.9258023&lon=77.6860099&lang=\(lang)&exclude=minutely&units=metric&appid=\(APPConstants.appKey)") else {
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

