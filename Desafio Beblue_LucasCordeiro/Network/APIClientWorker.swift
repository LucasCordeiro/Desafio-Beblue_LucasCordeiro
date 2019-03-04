//
//  APIClientWorker.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Alamofire

/// Class that willl provide services to view models
class APIClientWorker {

    /// Perform request with information
    ///
    /// - Parameters:
    ///   - route: route/path
    ///   - decoder: decoder (JSONDecoder as default)
    ///   - completion: completion called after finishing request
    /// - Returns: DataRequest
    @discardableResult
    private static func performRequest<T: Decodable>(route: APIRouterWorker,
                                                     decoder: JSONDecoder = JSONDecoder(),
                                                     completion: @escaping (Result<T>) -> Void) -> DataRequest {
        /*
         let manager = Alamofire.SessionManager.default
         manager.session.configuration.timeoutIntervalForRequest = 120
         */
        return Alamofire.Session.default.request(route)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T>) in
                completion(response.result)
        }
    }

    /// Get news from API
    ///
    /// - Parameters:
    ///   - completion: completion called after finishing request
    static func listMarsRoverPhotos(filter: String, date: String, completion: @escaping (Result<RoverPhoto>) -> Void) {
        let jsonDecoder = JSONDecoder()
        let route = APIRouterWorker.listMarsRoverPhotos(filter: filter, date: date)

        performRequest(route: route, decoder: jsonDecoder, completion: completion)
    }
}
