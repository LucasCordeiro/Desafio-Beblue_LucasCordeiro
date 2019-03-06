//
//  ConstantCenter.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

/// Server Infos/links/keys
struct ServerInfo {

    static let isProduction = true

    /// Mars Api Authentication Key
    static let marsApiKey = isProduction ? "AJRbFmue5nNlLX90zAQiG4fgeSvyorV5LPGVa4fY" : "DEMO_KEY"

    /// Service sever urls
    struct ServiceServer {
        /// URL to access Nasa Photos Rover API
        static let photosRoverApiUrl = isProduction
            ? "https://api.nasa.gov/mars-photos/api/v1/rovers/"
            : "https://testServer.com"

        /// URL suffix of Nasa API with apiKey
        static let suffixURL = "&api_key=\(marsApiKey)"
    }
}

/// Http header informations
///
/// - authentication: authentication value - "Authorization"
/// - contentType: content-tupe value - "Content-Type"
/// - acceptType: accept type value - "Accept"
/// - acceptEncoding: accept encoding value - "Accept-Encoding"
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

/// Content type values
///
/// - json: "application/json"
enum ContentType: String {
    case json = "application/json"
}

/// Colors used on project
struct ColorsConst {

    /// Main color
    static let mainColor = #colorLiteral(red: 0.06666666667, green: 0.2941176471, blue: 0.5450980392, alpha: 1)
    static let mainAuxiliarColor = #colorLiteral(red: 0.02079348675, green: 0.07361014222, blue: 0.1938593734, alpha: 1)

    static let secundaryColor = #colorLiteral(red: 0.3333333333, green: 0.3254901961, blue: 0.3803921569, alpha: 1)
    static let secundaryAuxiliarColor = #colorLiteral(red: 0.1607843137, green: 0.137254902, blue: 0.1882352941, alpha: 1)
}
