//
//  CurrentWeather.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
struct Weather: Decodable {

    var temperature: Double

    enum ContainerCodingKeys: String, CodingKey {
        case main
    }
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        temperature = try nestedContainer.decode(Double.self, forKey: .temperature)
    }
    
}
