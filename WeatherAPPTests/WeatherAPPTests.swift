//
//  WeatherAPPTests.swift
//  WeatherAPPTests
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import XCTest
@testable import WeatherAPP

final class WeatherAPPTests: XCTestCase {
    
    func testGetCurrentWeather() {
        let expectation = XCTestExpectation(description: "Get current weather")
        
        let lat = 37.7749
        let lon = -122.4194
        
        let weatherAPI = LocationWeatherManager()
        weatherAPI.getCurrentWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weather):
                // Assert that the weather object is not nil or empty
                XCTAssertNotNil(weather)
                
                // Additional assertions on the weather object's properties can be performed here
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get current weather: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetDailyWeather() {
        let expectation = XCTestExpectation(description: "Get daily weather")
        
        let lat = 37.7749
        let lon = -122.4194
        
        let weatherAPI = LocationWeatherManager()
        weatherAPI.getDailyWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let dailyWeather):
                // Assert that the daily weather object is not nil or empty
                XCTAssertNotNil(dailyWeather)
                
                // Additional assertions on the daily weather object's properties can be performed here
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get daily weather: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetCity() {
        // Create an expectation for the asynchronous completion handler
        let expectation = self.expectation(description: "Get city completion")
        let cityAPI = CityManager()
        // Perform the API request and test the completion handler
        cityAPI.getCity(query: "New York") { cityArray in
            // Assert that the cityArray is not empty
            XCTAssertFalse(cityArray.isEmpty)
            
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled with a timeout
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
