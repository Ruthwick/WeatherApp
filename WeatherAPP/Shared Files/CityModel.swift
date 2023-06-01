//
//  CityModel.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 01/06/23.
//

import Foundation

class CityModel {
    
    var cities: [CityObject]?
    
    static let shared = CityModel()
    private init () {}
    
    func getCity(query: String) {
       let queue = DispatchQueue(label: "cityResponse")
       queue.async {
           CityManager.shared.getCity(query: query) { [weak self] newCity in
               if newCity.count > 0 {
                  self?.cities = newCity
               }else {
                   // If the API fails to fetch the data then we go for backup here which is store in the app
                   self?.getCityFromBackup(compelition: { [weak self] cityListArray in
                       self?.cities = cityListArray
                   })
               }
          }
       }
    }
    
    func mapAPIResponseToCityObject(apiResponseData: Data) throws -> [CityObject] {
        let decoder = JSONDecoder()
        let apiResponse = try decoder.decode(APIResponse.self, from: apiResponseData)
        
        let customModels = apiResponse.data.map { apiObject in
            let coOrdinates = CoordCity(lat: apiObject.lat,lon:apiObject.lon)
            return  CityObject(name:apiObject.name,country:apiObject.country,coord:coOrdinates)
        }
        
        return customModels
    }
    
    func getCityFromBackup(compelition: @escaping ([CityObject]) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "city", ofType: "json") else { return }
       
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([CityObject].self, from: data)
            DispatchQueue.main.async {
                compelition(object)
            }
        } catch {
            print("Can't parse cities \(error.localizedDescription)")
        }
    } 
    
}
