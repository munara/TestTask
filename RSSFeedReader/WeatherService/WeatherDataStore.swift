//
//  WeatherDataStore.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import CoreData

class WeatherDataStore: NSObject {
    let persistence = PersistenceService.shared
    let networking = WeatherNetworkingService.shared
    
    override init() {
        super.init()
    }
    func fetchCurrentWeather(city: String, completion: @escaping(Weather?) -> Void) {
        networking.fetchCurrentWeather(city: city) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            case .success(let data):
                completion(data)
            }
        }
    }
    
    func saveCity(name: String, completion: @escaping([City]) -> Void ) {
        
        let city = City(context: self.persistence.context)
        city.name = name
        
        DispatchQueue.main.async {
            self.persistence.save {
                self.persistence.fetch(type: City.self) { result in
                    completion(result)
                }
            }
        }
        
    }
    func fetchCities(completion: @escaping([City]) -> Void) {
        self.persistence.fetch(type: City.self) { result in
            completion(result)
        }
    }
    func deleteCity(city: City, completion: @escaping() -> Void) {
        self.persistence.context.delete(city)
        self.persistence.save {
            completion()
        }
    }
    func fetchTemps(city: City, completion: @escaping([Weather]?) -> Void) {
        self.networking.fetchTemps(city: city.wrappedName) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            case .success(let data):
                completion(data)
            }
        }
    }
    
}
