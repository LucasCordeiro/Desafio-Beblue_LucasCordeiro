//
//  APIRouterWorker.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Alamofire

/// API that will provide requests informations
enum APIRouterWorker: URLRequestConvertible {

    //
    // MARK: - Listing -
    case listMarsRoverPhotos(filter: String, date: String)

    //
    // MARK: - HTTPMethod -
    private var method: HTTPMethod {
        switch self {
        case .listMarsRoverPhotos:
            return .get
        }
    }

    //
    // MARK: - Path -
    private var path: String {
        switch self {
        case .listMarsRoverPhotos(let filter, let date):
            return "\(filter)/photos?earth_date=\(date)" +
                ServerInfo.ServiceServer.suffixURL
        }
    }

    //
    // MARK: - Parameters -
    private var parameters: Parameters? {
        switch self {
        case .listMarsRoverPhotos:
            return nil
        }
    }

    //
    // MARK: - URLRequestConvertible -
    func asURLRequest() throws -> URLRequest {

        var url: URL

        //
        // Path
        switch self {
        case .listMarsRoverPhotos:
            let urlString = ServerInfo.ServiceServer.photosRoverApiUrl + path
            url = try urlString.asURL()
        }

        var urlRequest = URLRequest(url: url)

        //
        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        //
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        //
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
