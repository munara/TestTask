//
//  ForecastWeather.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

struct ForeCastWeather: Decodable {

    var weather: [Weather]

    enum ContainerCodingKeys: String, CodingKey {
        case list
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
       
        weather = try container.decode([Weather].self, forKey: .list)
    }
    
}
