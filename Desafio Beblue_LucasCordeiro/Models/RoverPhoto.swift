//
//  RoverPhoto.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation

struct RoverPhoto: Codable {
    let photosInfo: [RoverPhotoInfo]?

    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct RoverPhotoInfo: Codable {
    let camera: RoverCamera?
    let imageSource: String?

    enum CodingKeys: String, CodingKey {
        case imageSource = "img_src"

        case camera
    }
}

struct RoverCamera: Codable {
    let name: String?
    let fullName: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"

        case name
    }
}
