//
//  WeatherViewModel.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
protocol WeatherDisplayDelegate: class {
    func updateData()
    func deleteTableViewRow(indexPath: IndexPath)
}
protocol WeatherActionDelegate: class {
    func showDescription(city: City)
}
class WeatherViewModel {
    
    private let dataStore: WeatherDataStore
    weak var displayDelegate: WeatherDisplayDelegate?
    weak var actionDelegate: WeatherActionDelegate?
    private var worldCities: [String]?
    private var currentCities = [City]()
    var isCitySelected = false
    init(dataStore: WeatherDataStore) {
        self.dataStore = dataStore
    }
    
    func fetchWorldCities() {
        if let filepath = Bundle.main.path(forResource: "world-cities", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let lineArray = contents.components(separatedBy: "\n")
                var cities = [String]()
                for eachLine in lineArray {
                    let wordArray = eachLine.components(separatedBy: ",")
                    cities.append(wordArray[0])
                }
                worldCities = cities.sorted()
            } catch {
                print("contents could not be loaded")
            }
        } else {
             print("world-cities.txt not found!")
        }
        
    }
    func fetchCurrentCities() {
        dataStore.fetchCities { [weak self] result in
            self?.currentCities = result
            DispatchQueue.main.async {
                self?.displayDelegate?.updateData()
            }
        }
    }
    
    func getWorldCitiesCount() -> Int? {
        return worldCities?.count
    }
    
    func getCityName(by index: Int) -> String? {
        return worldCities?[index]
    }
    
    func addCity(with name: String) {
        if currentCities.contains(where: {$0.wrappedName == name})
            && !(worldCities?.contains(name) ?? false) {
            
            return
        }
        
        dataStore.saveCity(name: name) { [weak self] result in
            self?.currentCities = result
            self?.displayDelegate?.updateData()
        }
    }
    
    func getCount() -> Int {
        return currentCities.count
    }
    func getCurrentCityName(by index: Int) -> String {
        return currentCities[index].wrappedName
    }
    func getCurrentCityTemp(by index: Int, completion: @escaping(String) -> Void) {
        let city = currentCities[index]
        dataStore.fetchCurrentWeather(city: city.wrappedName) { weather in
           completion( String(weather?.temperature ?? 0.0))
           
        }
    }
    func deleteCity(with indexPath: IndexPath) {
        let city = currentCities[indexPath.row]
        dataStore.deleteCity(city: city) {
            self.currentCities.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.displayDelegate?.deleteTableViewRow(indexPath: indexPath)
           }
        }
    }
    func showDescription(index: Int) {
        actionDelegate?.showDescription(city: currentCities[index]) 
    }
}
