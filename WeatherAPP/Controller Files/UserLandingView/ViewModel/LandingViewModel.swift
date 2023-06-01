//
//  LandingViewModel.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation
import Network
import CoreLocation

enum keys {
    static let firstStart = "firstStart" 
}

class LandingViewModel: NSObject {
    
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var showError: (()->())?
    var loadWeatherController: (()->())?
    var loadStartController: (()->())?
    var weather = WeatherModel()
    var isLocationCalled = false
    
    private let locationManager = CLLocationManager()
    private let monitor = NWPathMonitor()
    
    func checkFirstStart(){
        showLoading?()
        if  UserDefaults.standard.value(forKey: keys.firstStart) == nil {
            loadStartController?()
        } else {
            checkNetwork()
        }
    }
    
   private func checkNetwork(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.actualLocation()
                if self.locationManager.authorizationStatus == .denied {
                    self.getWeather()
                }
            } else {
                DispatchQueue.main.async {
                    self.showError?()
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }

    private func getWeather() {
        LoadingIndicator.shared.show()
        if weather.lat != nil && weather.lon != nil {
            self.weather.withGeolocationWeather {
                self.hideLoading?()
                self.loadWeatherController?() 
            }
        } else {
            self.weather.noGeolocationWeather {
                self.hideLoading?()
                self.loadWeatherController?()
            }
        }
    }
}

extension LandingViewModel:  CLLocationManagerDelegate  {
    
    private func actualLocation() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        self.getLocation(location: location)
        locationManager.stopUpdatingLocation()
        // Move to a different section as there are a chance of this getting called multiple time, which may cause navigation issues.
        if !isLocationCalled{
            self.isLocationCalled = true
            getWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
    
    func getLocation(location:CLLocationCoordinate2D){
     var savedLocation = [String:Double]()
        weather.fetchSavedLastCity(compelition: { locationData in
            savedLocation = locationData
        })
        if savedLocation["lat"] == 0{
            weather.lat = location.latitude
            weather.lon = location.longitude
            weather.saveLastCity(lat: location.latitude, lan: location.longitude)
        }else {
            weather.lat = savedLocation["lat"]
            weather.lon = savedLocation["lon"]
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .notDetermined, .restricted, .denied:
            getWeather()
            debugPrint("No access")
        case .authorizedAlways, .authorizedWhenInUse:
            debugPrint("Access")
        @unknown default:
            break
        }
    }
}

