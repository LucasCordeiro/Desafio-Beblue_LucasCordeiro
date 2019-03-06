//
//  MarsPhotosPresenterTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import Desafio_Beblue_LucasCordeiro

class MarsPhotosPresenterTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsPhotosDetailPresenter!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        setupMarsPhotosDetailPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsPhotosDetailPresenter() {
        sut = MarsPhotosDetailPresenter()
    }

    //
    // MARK: - Spys -
    class MarsPhotosDetailDisplayLogicSpy: MarsPhotosDetailDisplayLogic {

        var displayPhotosInfoCalled = false
        var displayButtonNameCalled = false

        func displayPhotosInfo(viewModel: MarsPhotosDetail.LoadPhotosInfo.ViewModel) {
            displayPhotosInfoCalled = true
        }

        func displayButtonName(viewModel: MarsPhotosDetail.ChangeButtonName.ViewModel) {
            displayButtonNameCalled = true
        }
    }

    //
    // MARK: - Test Methods -
    func testPresentPhotosInfo() {
        //
        // Given
        let viewControllerSpy = MarsPhotosDetailDisplayLogicSpy()
        let camera = RoverCamera(name: "", fullName: "")
        let photoInfo = RoverPhotoInfo(camera: camera, imageSource: "www.image.com.br")
        let response = MarsPhotosDetail.LoadPhotosInfo.Response(photoInfo: photoInfo)
        sut.viewController = viewControllerSpy

        //
        // When
        sut.presentPhotosInfo(response: response)

        //
        // Then
        XCTAssert(viewControllerSpy.displayPhotosInfoCalled,
                  "displayPhotosInfo should be called righ after calling presentPhotosInfo")
    }

    func testPresentNewButtonName() {
        //
        // Given
        let viewControllerSpy = MarsPhotosDetailDisplayLogicSpy()
        let response = MarsPhotosDetail.ChangeButtonName.Response(buttonName: "")
        sut.viewController = viewControllerSpy

        //
        // When
        sut.presentNewButtonName(response: response)

        //
        // Then
        XCTAssert(viewControllerSpy.displayButtonNameCalled,
                  "displayButtonName should be called righ after calling presentPhotosInfo")
    }
}
