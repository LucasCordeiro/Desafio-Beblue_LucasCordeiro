//
//  MarsPhotosDetailInteractorTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import Desafio_Beblue_LucasCordeiro

class MarsPhotosDetailInteractorTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsPhotosDetailInteractor!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        setupMarsPhotosDetailInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsPhotosDetailInteractor() {
        sut = MarsPhotosDetailInteractor()
    }

    //
    // MARK: - Spys -
    class MarsPhotosDetailPresentationLogicSpy: MarsPhotosDetailPresentationLogic {

        var presentPhotosInfoCalled = false
        var presentNewButtonNameCalled = false

        func presentPhotosInfo(response: MarsPhotosDetail.LoadPhotosInfo.Response) {
            presentPhotosInfoCalled = true
        }

        func presentNewButtonName(response: MarsPhotosDetail.ChangeButtonName.Response) {
            presentNewButtonNameCalled = true
        }
    }

    //
    // MARK: - Test Methods -
    func testCallingPresentPhotosInfo() {
        //
        // Given
        let presenterSpy = MarsPhotosDetailPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.roverPhotoInfo = RoverPhotoInfo(camera: nil, imageSource: nil)
        let request = MarsPhotosDetail.LoadPhotosInfo.Request()

        //
        // When
        sut.loadPhotosInfo(request: request)

        //
        // Then
        XCTAssertTrue(presenterSpy.presentPhotosInfoCalled,
                      "presentPhotosInfoCalled should be called right after calling loadPhotosInfo")
    }

    func testCallingChangeButtonNameFrom() {
        //
        // Given
        let presenterSpy = MarsPhotosDetailPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.roverPhotoInfo = RoverPhotoInfo(camera: nil, imageSource: nil)
        let request = MarsPhotosDetail.ChangeButtonName.Request(currentButtonName: "")

        //
        // When
        sut.changeButtonName(request: request)

        //
        // Then
        XCTAssertTrue(presenterSpy.presentNewButtonNameCalled,
                      "presentNewButtonNameCalled should be called right after calling loadPhotosInfo")
    }
}
