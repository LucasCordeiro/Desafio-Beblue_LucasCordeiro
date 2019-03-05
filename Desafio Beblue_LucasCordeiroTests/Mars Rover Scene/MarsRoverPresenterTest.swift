//
//  MarsRoverPresenterTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import Desafio_Beblue_LucasCordeiro

class MarsRoverPresenterTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsRoverPresenter!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        setupMarsRoverPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsRoverPresenter() {
        sut = MarsRoverPresenter()
    }

    //
    // MARK: - Spys -
    class MarsRoverDisplayLogicSpy: MarsRoverDisplayLogic {

        var displayMarsPhotosCalled = false
        var displayMarsPhotosPaginationCalled = false

        func displayMarsPhotos(viewModel: MarsRover.ListMarsRoverPhotos.ViewModel) {
            displayMarsPhotosCalled = true
        }

        func displayMarsPhotosPagination(viewModel: MarsRover.ListMarsRoverPhotos.ViewModel) {
            displayMarsPhotosPaginationCalled = true
        }
    }

    //
    // MARK: - Test Methods -
    func testPresentListMarsRoverPhotos() {
        let viewControllerSpy = MarsRoverDisplayLogicSpy()
        let response = MarsRover.ListMarsRoverPhotos.Response(photosInfo: nil, isError: false, errorMessage: nil)
        sut.viewController = viewControllerSpy

        sut.presentListMarsRoverPhotos(response: response)

        XCTAssert(viewControllerSpy.displayMarsPhotosCalled,
                  "displayMarsPhotosCalled should be called righ after calling presentListMarsRoverPhotos")
    }

    func testPresentPaginateMarsRoverPhotos() {
        let viewControllerSpy = MarsRoverDisplayLogicSpy()
        let response = MarsRover.PaginateMarsRoverPhotos.Response(photosInfo: nil, isError: false, errorMessage: nil)
        sut.viewController = viewControllerSpy

        sut.presentPaginateMarsRoverPhotos(response: response)

        XCTAssert(viewControllerSpy.displayMarsPhotosPaginationCalled,
                  "displayMarsPhotosCalled should be called righ after calling presentPaginateMarsRoverPhotos")
    }

    func testMarsRoverPhotoViewModel() {
        let imageSource = "www.image.com.br"
        let photoInfo = RoverPhotoInfo(camera: nil, imageSource: imageSource)

        let viewModel = sut.marsRoverPhotoViewModel(from: [photoInfo])

        XCTAssert(viewModel.marsRoverPhotos[0].photosUrl.absoluteString == imageSource,
                  "ViewModel URL should be the same address passes as imageSource in photoInfo")
    }

    func testPresentListMarsRoverPhotosErrorPresentMessage() {
        let viewControllerSpy = MarsRoverDisplayLogicSpy()
        let response = MarsRover.ListMarsRoverPhotos.Response(photosInfo: nil, isError: true, errorMessage: nil)
        sut.viewController = viewControllerSpy

        sut.presentListMarsRoverPhotos(response: response)

        XCTAssertFalse(viewControllerSpy.displayMarsPhotosCalled, "displayMarsPhotosCalled should be called righ after calling presentListMarsRoverPhotos")
    }

    func testPresentPaginateMarsRoverPhotosErrorPresentMessage() {
        let viewControllerSpy = MarsRoverDisplayLogicSpy()
        let response = MarsRover.PaginateMarsRoverPhotos.Response(photosInfo: nil, isError: true, errorMessage: nil)
        sut.viewController = viewControllerSpy

        sut.presentPaginateMarsRoverPhotos(response: response)

        XCTAssertFalse(viewControllerSpy.displayMarsPhotosPaginationCalled, "displayMarsPhotosCalled should be called righ after calling presentPaginateMarsRoverPhotos")
    }
}
