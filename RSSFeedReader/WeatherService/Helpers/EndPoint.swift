//
//  EndPoint.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

public enum WeatherAPI {
    case currentWeather(cityName: String, apiKey: String)
    case temps(cityName: String, apiKey: String)
}

extension WeatherAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/?")
            else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return  "weather?"
        case .temps:
            return "forecast?"
        }
    }
    //
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
         switch self {
         case .currentWeather(let cityName, let apiKey):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["q": cityName,
                                                      "appid": apiKey])
         case .temps(let cityName, let apiKey):
            return .requestParameters(bodyParameters: nil,
                                   bodyEncoding: .urlEncoding,
                                   urlParameters: ["q": cityName,
                                                   "appid": apiKey])

         }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
