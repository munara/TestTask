//
//  URLParameterEncoder.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
public struct URLParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest,
                       with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else {
            return
        }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false),
                                !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {

                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
    }
}
