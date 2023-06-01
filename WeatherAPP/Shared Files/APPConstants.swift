//
//  APPConstants.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation

struct APPConstants {
    static let weatherViewController = "WeatherViewController"
    static let searchViewController = "SearchViewController"
    static let startViewController = "StartViewController"
    static let baseURL = "https://api.openweathermap.org/"
    static let appKey = "1c2ba745810db56a9f945361a2520a0a" 
    
    struct cells {
        static let searchTableViewCell = "SearchTableViewCell"
        static let selfLocationTableViewCell = "SelfLocationTableViewCell"
        static let hourlyCollectionViewCell = "HourlyCollectionViewCell"
        static let dailyCollectionViewCell = "DailyCollectionViewCell"
    }
    
}
