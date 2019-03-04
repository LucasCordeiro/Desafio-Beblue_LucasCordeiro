//
//  MarsRoverWorker.swift
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

typealias ListMarsRoverPhotosResponseHandler = (
    _ photosInfo: [RoverPhotoInfo]?,
    _ isError: Bool,
    _ message: String?) -> Void

class MarsRoverWorker {
    func listMarsRoverPhotos(filter: String,
                             date: String,
                             completion: @escaping(ListMarsRoverPhotosResponseHandler)) {

        APIClientWorker.listMarsRoverPhotos(filter: filter, date: date) { (result) in
            if let validResult = try? result.unwrap() {
                completion(validResult.photosInfo, false, nil)
            } else {
                completion(nil, true, "Result not found")
            }
        }
    }
}
