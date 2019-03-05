//
//  MarsRoverWorkerTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
import Alamofire
@testable import Desafio_Beblue_LucasCordeiro

class MarsRoverWorkerTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsRoverWorker!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        setupMarsRoverWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsRoverWorker() {
        sut = MarsRoverWorker()
    }

    //
    // MARK: - Test Methods -
    func testListMarsRoverPhotosCallingWorker() {
        //
        // TODO: Need mock with ohhttpstubs to simulate APIClientWorker
    }
}
