//
//  MarsPhotosDetailViewControllerTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
import SDWebImage
@testable import Desafio_Beblue_LucasCordeiro

class MarsPhotosDetailViewControllerTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsPhotosDetailViewController!
    var window: UIWindow!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMarsPhotosDetailViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsPhotosDetailViewController() {
        sut = MarsPhotosDetailViewController.storyboardInit()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    //
    // MARK: - Spys -
    class MarsPhotosDetailBusinessLogicSpy: MarsPhotosDetailBusinessLogic, MarsPhotosDetailDataStore {

        //
        // MARK: - Method call expectations -
        var loadPhotosInfoCalled = false
        var changeButtonNameCalled = false
        var roverPhotoInfo: RoverPhotoInfo! = RoverPhotoInfo(camera: nil, imageSource: nil)
        //
        // MARK: - Spied Methods -
        func loadPhotosInfo(request: MarsPhotosDetail.LoadPhotosInfo.Request) {
            loadPhotosInfoCalled = true
        }

        func changeButtonName(request: MarsPhotosDetail.ChangeButtonName.Request) {
            changeButtonNameCalled = true
        }
    }

    class UIImageViewSpy: UIImageView {

        //
        // MARK: - Method call expectations -
        var isError = false
        var sdSetImageCalled = false

        //
        // MARK: - Spied Methods -
        override func sd_setImage(with url: URL?,
                                  placeholderImage placeholder: UIImage?,
                                  options: SDWebImageOptions = [],
                                  progress progressBlock: SDWebImageDownloaderProgressBlock?,
                                  completed completedBlock: SDExternalCompletionBlock? = nil) {
            sdSetImageCalled = true
            if let completedBlock = completedBlock {
                var error: Error?
                if isError {
                    error = NSError(domain: "-1001", code: 1001, userInfo: nil) as Error
                }
                completedBlock(nil, error, .none, nil)
            }
        }
    }

    //
    // MARK: - Test Methods -

    func testLoadPhotosInfoCalled() {
        //
        // Given
        let marsPhotosDetailBusinessLogicSpy = MarsPhotosDetailBusinessLogicSpy()
        sut.interactor = marsPhotosDetailBusinessLogicSpy
        loadView()

        //
        // When
        sut.viewDidLoad()

        //
        // Then
        XCTAssert(marsPhotosDetailBusinessLogicSpy.loadPhotosInfoCalled,
                  "Should call load photos info right after the view did load")
    }

    func testChangeButtonNameCalled() {
        //
        // Given
        let marsPhotosDetailBusinessLogicSpy = MarsPhotosDetailBusinessLogicSpy()
        sut.interactor = marsPhotosDetailBusinessLogicSpy
        loadView()

        //
        // When
        sut.changeButtonName()

        //
        // Then
        XCTAssert(marsPhotosDetailBusinessLogicSpy.changeButtonNameCalled,
                  "Should call load photos info right after the view did load")
    }

    func testCallSdSetImage() {
        //
        // Given
        let marsPhotosDetailBusinessLogicSpy = MarsPhotosDetailBusinessLogicSpy()
        sut.interactor = marsPhotosDetailBusinessLogicSpy
        loadView()
        let imageViewSpy = UIImageViewSpy()
        sut.imageViewOutlet = imageViewSpy
        let url = URL(string: "www.image.com.br")!
        let viewModel = MarsPhotosDetail.LoadPhotosInfo.ViewModel(photosUrl: url, buttonName: "")

        //
        // When
        sut.displayPhotosInfo(viewModel: viewModel)

        //
        // Then
        XCTAssert(imageViewSpy.sdSetImageCalled,
                  "Should call sdSetImageCalled right after the displayPhotosInfo")
    }

    func testChangeButtonNameAfterDisplayPhotosInfo() {
        //
        // Given
        let marsPhotosDetailBusinessLogicSpy = MarsPhotosDetailBusinessLogicSpy()
        sut.interactor = marsPhotosDetailBusinessLogicSpy
        loadView()
        let url = URL(string: "www.image.com.br")!
        let buttonName = "buttonName"
        let viewModel = MarsPhotosDetail.LoadPhotosInfo.ViewModel(photosUrl: url, buttonName: buttonName)

        //
        // When
        sut.displayPhotosInfo(viewModel: viewModel)

        //
        // Then
        XCTAssert(sut.roverButtonOutlet.title(for: UIControl.State()) == buttonName,
                  "Should change roverButtonOutlet title to buttonName value")
    }

    func testChangeButtonNameAfterDisplayButtonName() {
        //
        // Given
        let marsPhotosDetailBusinessLogicSpy = MarsPhotosDetailBusinessLogicSpy()
        sut.interactor = marsPhotosDetailBusinessLogicSpy
        loadView()
        let buttonName = "buttonName"
        let viewModel = MarsPhotosDetail.ChangeButtonName.ViewModel(buttonName: buttonName)

        //
        // When
        sut.displayButtonName(viewModel: viewModel)

        //
        // Then
        XCTAssert(sut.roverButtonOutlet.title(for: UIControl.State()) == buttonName,
                  "Should change roverButtonOutlet title to buttonName value")
    }
}
