//
//  MarsRoverPresenter.swift
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

protocol MarsRoverPresentationLogic {
  func presentListMarsRoverPhotos(response: MarsRover.ListMarsRoverPhotos.Response)
}

class MarsRoverPresenter: MarsRoverPresentationLogic {
  weak var viewController: MarsRoverDisplayLogic?

  // MARK: Do something

  func presentListMarsRoverPhotos(response: MarsRover.ListMarsRoverPhotos.Response) {

    var marsRoverPhotos: [MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto] = []
    for photoInfo in response.photosInfo ?? [] {
        guard let url = URL(string: photoInfo.imageSource ?? "") else {
            continue
        }
        let marsRoverPhoto = MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(photosUrl: url)
        marsRoverPhotos.append(marsRoverPhoto)
    }

    let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)
    viewController?.displayMarsPhotos(viewModel: viewModel)
  }
}
