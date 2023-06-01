//
//  CityManager.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 01/06/23.
//

import Foundation

class CityManager {
    
    static let shared = CityManager()
    init () {}

    func getCity(query:String, completion: @escaping ([CityObject]) -> ()) {
        LoadingIndicator.shared.show()
        guard let url = URL(string: "\(APPConstants.baseURL)geo/1.0/direct?q=\(query)&limit=5&appid=\(APPConstants.appKey)") else {
            LoadingIndicator.shared.hide()
            completion([])
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                LoadingIndicator.shared.hide()
                completion([])
                return
            }
            do {
                let cityArray = try CityModel.shared.mapAPIResponseToCityObject(apiResponseData: data)
                debugPrint("cityArray: \(cityArray)")
                LoadingIndicator.shared.hide()
                completion(cityArray)
            } catch {
                LoadingIndicator.shared.hide()
                completion([])
            }
        }.resume()
    } 
    
}
