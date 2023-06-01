//
//  WeatherViewModel.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation
import UIKit

class WeatherViewModel {
    
    //MARK: - vars/lets
    var navigationBarTitle = APPBindable<String?>(nil)
    var currentPressure = APPBindable<String?>(nil)
    var currentHumidity = APPBindable<String?>(nil)
    var currentDescription =  APPBindable<String?>(nil)
    var currentTemperature = APPBindable<String?>(nil)
    var currentFeelingWeather = APPBindable<String?>(nil)
    var currentImageWeather = APPBindable<UIImage?>(nil)
    var currentMinWeather = APPBindable<String?>(nil)
    var currentMaxWeather = APPBindable<String?>(nil)
    var currentWindSpeed = APPBindable<String?>(nil)
    var currentTime = APPBindable<String?>(nil)
    var backgroundImageView = APPBindable<UIImage?>(nil)
    var currentWeatherObject = APPBindable<CurrentWeather?>(nil)
    var dailyCollectionView = APPBindable<DailyWeather?>(nil)
    
    var weather = WeatherModel()
    var reloadCollectionView: (()->())?
    
    var numberOfDailyCells: Int {
        return weather.dailyWeather?.daily.count ?? 8
    }
    
    var numberOfHourlyCells: Int {
        return weather.dailyWeather?.hourly.count ?? 24
    }
    
    
    //MARK: - flow func
    func addWeatherSettings() {
        guard let currentWeather = self.weather.currentWeather else { return }
        self.navigationBarTitle.value = currentWeather.name
        self.currentTime.value = dateFormater(date: currentWeather.dt, dateFormat: "HH:mm E")
        self.currentTemperature.value = "\(currentWeather.main.temp.doubleToString())°"
        self.currentFeelingWeather.value = "\(currentWeather.main.feels_like.doubleToString())°"
        self.currentMaxWeather.value = "\(currentWeather.main.temp_max.doubleToString())°"
        self.currentMinWeather.value = "\(currentWeather.main.temp_min.doubleToString())°"
        self.currentImageWeather.value = UIImage(named: "\(currentWeather.weather.first!.icon)-1.png")
        self.currentDescription.value = currentWeather.weather.first!.description.capitalizingFirstLetter()
        self.currentPressure.value = "\(currentWeather.main.pressure.doubleToString())мм"
        self.currentWindSpeed.value = "\(currentWeather.wind.speed)м/с"
        self.currentHumidity.value = "\(currentWeather.main.humidity.doubleToString())%"
        self.backgroundImageView.value = UIImage(named: "\(currentWeather.weather.first!.icon)-2")
        self.reloadCollectionView?()
    }

    func getWeather () {
        if weather.lat != nil && weather.lon != nil {
            weather.withGeolocationWeather {
                self.addWeatherSettings()
            }
        } else {
            weather.noGeolocationWeather {
                self.addWeatherSettings()
            }
     
        }
    }
    
    private func dateFormater(date: TimeInterval, dateFormat: String) -> String {
        let dateText = Date(timeIntervalSince1970: date )
        let formater = DateFormatter()
        formater.timeZone = TimeZone(secondsFromGMT: weather.currentWeather?.timezone ?? 0)
        formater.dateFormat = dateFormat
        return formater.string(from: dateText)
        
    }
    
    //MARK: - collection cells configure
    func dailyConfigureCell (cell: DailyCollectionViewCell, indexPath: IndexPath) -> DailyCollectionViewCell {
        if let daily = weather.dailyWeather?.daily {
            cell.configure(daily: daily[indexPath.row], indexPath: indexPath.row)
            cell.dailyDate.text = dateFormater(date: (daily[indexPath.row].dt), dateFormat: "E d MMM")
        }
        return cell
    }
    
    
    func hourlyConfigureCell (cell: HourlyCollectionViewCell, indexPath: IndexPath) -> HourlyCollectionViewCell {
        if let hourly = weather.dailyWeather?.hourly {
            cell.configure(hourly: hourly[indexPath.row], indexPath: indexPath.row)
            cell.hourlyTime.text = dateFormater(date: (hourly[indexPath.row].dt), dateFormat: "HH:mm")
        }
        return cell
    }
    
}

//MARK: - Extensions
extension WeatherViewModel:SearchViewModelDelegate {
    func setLocation(_ lat: Double, _ lon: Double) {
        self.weather.lon = lon
        self.weather.lat = lat
        weather.saveLastCity(lat: lat, lan: lon)
        getWeather()
    }
}

