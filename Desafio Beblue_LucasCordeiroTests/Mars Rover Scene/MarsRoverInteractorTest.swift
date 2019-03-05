//
//  MarsRoverInteractorTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import Desafio_Beblue_LucasCordeiro

class MarsRoverInteractorTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsRoverInteractor!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        setupMarsRoverInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsRoverInteractor() {
        sut = MarsRoverInteractor()
    }

    //
    // MARK: - Spys -
    class MarsRoverPresentationLogicSpy: MarsRoverPresentationLogic {

        var presentListMarsRoverPhotosCalled = false
        var presentPaginateMarsRoverPhotosCalled = false

        func presentListMarsRoverPhotos(response: MarsRover.ListMarsRoverPhotos.Response) {
            presentListMarsRoverPhotosCalled = true
        }

        func presentPaginateMarsRoverPhotos(response: MarsRover.PaginateMarsRoverPhotos.Response) {
            presentPaginateMarsRoverPhotosCalled = true
        }
    }

    class MarsRoverWorkerSpy: MarsRoverWorker {

        var isError = false
        var listMarsRoverPhotosCalled = false

        override func listMarsRoverPhotos(filter: String,
                                          date: String,
                                          completion: @escaping(ListMarsRoverPhotosResponseHandler)) {

            completion(nil, isError, nil)
            listMarsRoverPhotosCalled = true
        }
    }

    //
    // MARK: - Test Methods -
    func testListMarsRoverPhotosSetLastDate() {
        let date = Date()
        let request = MarsRover.ListMarsRoverPhotos.Request(filter: .opportunity, date: date)

        sut.listMarsRoverPhotos(request: request)

        XCTAssert(sut.lastDate == date, "Last date should be the same as request date")
    }

    func testListMarsRoverPhotosSetLastFilter() {
        let date = Date()
        let request = MarsRover.ListMarsRoverPhotos.Request(filter: .spirit, date: date)

        sut.listMarsRoverPhotos(request: request)

        XCTAssert(sut.lastFilter == .spirit, "Last filter should be the same as request filter")
    }

    func testCallingWorkerListMarsRoverPhotos() {
        let request = MarsRover.ListMarsRoverPhotos.Request(filter: .spirit, date: nil)
        let workerSpy = MarsRoverWorkerSpy()
        sut.worker = workerSpy

        sut.listMarsRoverPhotos(request: request)

        XCTAssertTrue(workerSpy.listMarsRoverPhotosCalled, "The woker method List Mars Rover Photos" +
            "should be called right after calling listMarsRoverPhotosCalled")
    }

    func testCallingPresentListMarsRoverPhotos() {
        let request = MarsRover.ListMarsRoverPhotos.Request(filter: .spirit, date: nil)
        let workerSpy = MarsRoverWorkerSpy()
        workerSpy.isError = false
        let presenterSpy = MarsRoverPresentationLogicSpy()
        sut.worker = workerSpy
        sut.presenter = presenterSpy

        self.sut.listMarsRoverPhotos(request: request)

        XCTAssertTrue(presenterSpy.presentListMarsRoverPhotosCalled, "The presenter method " +
        "presentListMarsRoverPhotosCalled should be called right after calling listMarsRoverPhotosCalled")
    }

    func testPaginateMarsRoverPhotosSetLastDate() {
        let date = Date()
        sut.lastDate = Date()
        let request = MarsRover.PaginateMarsRoverPhotos.Request()
        sut.lastFilter = .spirit

        sut.paginateMarsRoverPhotos(request: request)

        XCTAssert(sut.lastDate == date.dayBefore, "Last date should be a day before," +
            " after calling paginateMarsRoverPhotos")
    }

    func testCallingWorkerPaginateMarsRoverPhotos() {
        let request = MarsRover.PaginateMarsRoverPhotos.Request()
        let workerSpy = MarsRoverWorkerSpy()
        sut.lastFilter = .spirit
        sut.worker = workerSpy

        sut.paginateMarsRoverPhotos(request: request)

        XCTAssertTrue(workerSpy.listMarsRoverPhotosCalled, "The woker method List Mars Rover Photos" +
            "should be called right after calling paginateMarsRoverPhotos")
    }

    func testCallingPresentPaginateMarsRoverPhotos() {
        let request = MarsRover.PaginateMarsRoverPhotos.Request()
        let workerSpy = MarsRoverWorkerSpy()
        workerSpy.isError = false
        let presenterSpy = MarsRoverPresentationLogicSpy()
        sut.worker = workerSpy
        sut.presenter = presenterSpy
        sut.lastFilter = .spirit

        self.sut.paginateMarsRoverPhotos(request: request)

        XCTAssertTrue(presenterSpy.presentPaginateMarsRoverPhotosCalled, "The presenter method " +
            "presentPaginateMarsRoverPhotos should be called right after calling paginateMarsRoverPhotos")
    }

    func testSelectPhotoInfo() {
        let roverPhotoInfo = RoverPhotoInfo(camera: nil, imageSource: nil)
        sut.roverPhotosInfo = [roverPhotoInfo]

        let indexPath = IndexPath(item: 0, section: 0)
        sut.selectPhotoInfo(at: indexPath)

        XCTAssert(sut.selectedRoverPhotoInfo != nil, "Selected rover should be setted")

    }
}
