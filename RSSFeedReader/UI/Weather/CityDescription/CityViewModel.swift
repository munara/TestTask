//
//  CityViewModel.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
protocol CityDisplayDelegate: class {
    func updateData()
}
class CityViewModel {
    private let dataStore: WeatherDataStore
    private let city: City
    private var temps: [Weather]?
    weak var displayDelegate: CityDisplayDelegate?
    
    init(dataStore: WeatherDataStore, city: City) {
        self.dataStore = dataStore
        self.city = city
    }
    func fetchTemps() {
        dataStore.fetchTemps(city: city) {[weak self] result in
            self?.temps = result
            DispatchQueue.main.async {
                self?.displayDelegate?.updateData()
            }
        }
    }
    func getTemp(index: Int) -> String {
        return String(temps?[index].temperature ?? 0.0)
    }
    func getCityName() -> String {
        return city.wrappedName
    }
}
