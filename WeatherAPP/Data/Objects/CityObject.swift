//
//  CityObject.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation

class CityObject: Codable{
    var name: String
    var country: String
    var coord: CoordCity
    
    init(name: String, country: String, coord: CoordCity) {
        self.name = name
        self.country = country
        self.coord = coord
    }
}

class CoordCity: Codable {
    var lat: Double
    var lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

struct APIResponse: Codable {
    let data: [APIObject]
}

struct APIObject: Codable {
    var name: String
    var country: String
    var lat: Double
    var lon: Double
}
