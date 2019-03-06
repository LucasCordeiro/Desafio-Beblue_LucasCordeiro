//
//  MarsRoverModels.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright (c) 2019 Sparks. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MarsRover {

    enum ListMarsRoverPhotos {

        struct Request {
            let filter: RoverPhotosFilter
            let date: Date?
        }

        struct Response {
            var photosInfo: [RoverPhotoInfo]?
            var isError: Bool
            var errorMessage: String?
        }

        struct ViewModel {

            struct MarsRoverPhoto {
                var photosUrl: URL
            }

            var marsRoverPhotos: [MarsRoverPhoto]
        }
    }

    enum PaginateMarsRoverPhotos {

        struct Request {
        }

        struct Response {
            var photosInfo: [RoverPhotoInfo]?
            var isError: Bool
            var errorMessage: String?
        }

        struct ViewModel {

            struct MarsRoverPhoto {
                var photosUrl: URL
            }

            var marsRoverPhotos: [MarsRoverPhoto]
        }
    }
}
