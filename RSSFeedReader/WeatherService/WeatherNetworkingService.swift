//
//  WeatherNetworkingService.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

class WeatherNetworkingService {
    var apiKey: String = "8a90d276e9ae5c26e42513c372fe40ee"
    
    private init() {
    }
    static let shared = WeatherNetworkingService()
    
    func fetchCurrentWeather(city: String,
                             completion: @escaping(Result<Weather, Error>) -> Void) {
        let router = Router<WeatherAPI>()
        router.request(.currentWeather(cityName: city, apiKey: apiKey)) {result in
           switch result {
           case .failure(let error):
               completion(.failure(error))
           case .success(let data):
               do {
                   let apiResponse = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(apiResponse))
               } catch {
                   completion(.failure(error))
               }
           }
        }
    }
    func fetchTemps(city: String,
                    completion: @escaping(Result<[Weather], Error>) -> Void) {
        
        let router = Router<WeatherAPI>()
        router.request(.temps(cityName: city,
                                       apiKey: apiKey)) {result in
           switch result {
           case .failure(let error):
               completion(.failure(error))
           case .success(let data):
               do {
                   let apiResponse = try JSONDecoder().decode(ForeCastWeather.self, from: data)
                let temps = apiResponse.weather
                completion(.success(temps))
               } catch {
                   completion(.failure(error))
               }
           }
        }
    }
}
