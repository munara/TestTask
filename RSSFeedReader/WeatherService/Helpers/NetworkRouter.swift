//
//  NetworkRouter.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping(Result<Data, Error>) -> Void)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
               if let response = response as? HTTPURLResponse {
                    if let networkError = error {
                        completion(.failure(networkError))
                    } else {
                        guard let responseData = data else {
                            return
                        }
                        completion(.success(responseData))
                    }
                }
            })
        } catch {
            completion(.failure(error))
        }
        self.task?.resume()
    }
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint ) throws -> URLRequest {
        
        guard let urlText = URL(string: route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding ?? "") else {
            fatalError("Expected URL ")
        }

        var request = URLRequest(url: urlText,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 0.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
}
