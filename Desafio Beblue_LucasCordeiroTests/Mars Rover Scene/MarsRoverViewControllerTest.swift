//
//  MarsRoverViewControllerTest.swift
//  Desafio Beblue_LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 05/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import Desafio_Beblue_LucasCordeiro

class MarsRoverViewControllerTest: XCTestCase {

    //
    // MARK: - SUT -
    var sut: MarsRoverViewController!
    var window: UIWindow!

    //
    // MARK: - Test Lifecycle -
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMarsRoverViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    //
    // MARK: - Configure Test -
    func setupMarsRoverViewController() {
        sut = MarsRoverViewController.storyboardInit()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    //
    // MARK: - Spys -
    class MarsRoverBusinessLogicSpy: MarsRoverBusinessLogic {

        //
        // MARK: - Method call expectations -
        var listMarsRoverPhotosCalled = false
        var paginateMarsRoverPhotosCalled = false
        var listMarsRoverselectPhotoInfoCalled = false

        //
        // MARK: - Spied Methods -
        func listMarsRoverPhotos(request: MarsRover.ListMarsRoverPhotos.Request) {
            listMarsRoverPhotosCalled = true
        }

        func paginateMarsRoverPhotos(request: MarsRover.PaginateMarsRoverPhotos.Request?) {
            paginateMarsRoverPhotosCalled = true
        }

        func selectPhotoInfo(at indexPath: IndexPath) {
            listMarsRoverselectPhotoInfoCalled = true
        }
    }

    class CollectionViewSpy: UICollectionView {

        //
        // MARK: - Expectations Properties
        var reloadDataCalled = false
        var registerCalled = false

        //
        // MARK: - Spied Methods -
        override func reloadData() {
            reloadDataCalled = true
        }

        override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
            registerCalled = true
        }
    }

    class SegmentedControlSpy: UISegmentedControl {
    }

    //
    // MARK: - Test Methods -
    func testListMatsRovePhotoCalled() {
        //
        // Given
        let marsRoverBusinessLogicSpy = MarsRoverBusinessLogicSpy()
        sut.interactor = marsRoverBusinessLogicSpy
        loadView()

        //
        // When
        sut.viewDidLoad()

        //
        // Then
        XCTAssert(marsRoverBusinessLogicSpy.listMarsRoverPhotosCalled,
                  "Should list mars photos right after the view did load")
    }

    func testConfigureCollectionViewCellsCalled() {
        //
        // Given
        let collectionViewSpy = CollectionViewSpy.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                       collectionViewLayout: UICollectionViewLayout.init())
        loadView()
        sut.collectionView = collectionViewSpy

        //
        // When
        sut.viewDidLoad()

        //
        // Then
        XCTAssert(collectionViewSpy.registerCalled,
                  "Should register cells right after the view did load")
    }

    func testSegmentedInitialIndexCalled() {
        //
        // Given
        loadView()
        let segmentedSpy = SegmentedControlSpy(items: ["0", "1", "2"])
        segmentedSpy.selectedSegmentIndex = 1
        sut.filterSegmentedControllOutlet = segmentedSpy

        //
        // When
        sut.viewDidLoad()

        //
        // Then
        XCTAssert(segmentedSpy.selectedSegmentIndex == 0,
                  "Should set filter segmented selected index to 0 right after the view did load")
    }

    func testNumberOfSectionsInCollectionViewShouldAlwaysBeOne() {
        //
        // Given
        loadView()
        let collectionView = sut.collectionView

        //
        // When
        let numberOfSections = sut.numberOfSections(in: collectionView!)

        //
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of collection view sections should always be 1")
    }

    func testNumberOfItensInAnySectionShouldEqualNumberOfMarsRoverPhotos() {
        //
        // Given
        loadView()
        let collectionView = sut.collectionView
        let marsRoverPhotos = [MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))]
        sut.marsRoverPhotos = marsRoverPhotos

        //
        // When
        let numberOfRows = sut.collectionView(collectionView!, numberOfItemsInSection: 0)

        //
        // Then
        XCTAssertEqual(numberOfRows, marsRoverPhotos.count,
                       "The number of table view rows should equal the number of photos to display")
    }

    func testNumberOfItensInAnySectionShouldEqualNumberOfMarsRoverPhotosAfterDisplayMarsPhotos() {
        //
        // Given
        loadView()
        let marsRoverPhotos = [MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))]
        let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)

        //
        // When
        sut.displayMarsPhotos(viewModel: viewModel)

        //
        // Then
        XCTAssertEqual(sut.marsRoverPhotos.count, marsRoverPhotos.count,
                       "The number of mars photos in sut should equal the number of photos to display")
    }

    func testPaginateCallAfterDisplayLessThan20MarsPhotos() {
        //
        // Given
        let marsRoverBusinessLogicSpy = MarsRoverBusinessLogicSpy()
        sut.interactor = marsRoverBusinessLogicSpy
        loadView()
        let marsRoverPhotos = [MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))]
        let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)

        //
        // When
        sut.displayMarsPhotos(viewModel: viewModel)

        //
        // Then
        XCTAssertTrue(marsRoverBusinessLogicSpy.paginateMarsRoverPhotosCalled,
                      "Paginate method should be call if there are less than 20 objects")
    }

    func testPaginateNotCallAfterDisplayMoreThan20MarsPhotos() {
        //
        // Given
        let marsRoverBusinessLogicSpy = MarsRoverBusinessLogicSpy()
        sut.interactor = marsRoverBusinessLogicSpy
        loadView()
        let marsPhoto = MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))
        let marsRoverPhotos = [marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto,
                               marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto,
                               marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto,
                               marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto]
        let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)

        //
        // When
        sut.displayMarsPhotos(viewModel: viewModel)

        //
        // Then
        XCTAssertFalse(marsRoverBusinessLogicSpy.paginateMarsRoverPhotosCalled,
                       "Paginate method should not be call if there are more than 20 objects")
    }

    func testAppendMarsRoverPhotosAfterDisplayMarsPhotosPaginate() {
        //
        // Given
        loadView()
        let marsRoverPhotos = [MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))]
        sut.marsRoverPhotos = marsRoverPhotos
        let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)

        //
        // When
        sut.displayMarsPhotosPagination(viewModel: viewModel)

        //
        // Then
        XCTAssertEqual(sut.marsRoverPhotos.count, marsRoverPhotos.count * 2,
                       "The number of table view rows should equal the number of photos to display")
    }

    func testPaginateCallAfterPaginateLessThan20MarsPhotos() {
        //
        // Given
        let marsRoverBusinessLogicSpy = MarsRoverBusinessLogicSpy()
        sut.interactor = marsRoverBusinessLogicSpy
        loadView()
        let marsRoverPhotos = [MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))]
        let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)

        //
        // When
        sut.displayMarsPhotosPagination(viewModel: viewModel)

        //
        // Then
        XCTAssertTrue(marsRoverBusinessLogicSpy.paginateMarsRoverPhotosCalled,
                      "Paginate method should be call if there are less than 20 objects")
    }

    func testPaginateNotCallAfterPaginateMoreThan20MarsPhotos() {
        //
        // Given
        let marsRoverBusinessLogicSpy = MarsRoverBusinessLogicSpy()
        sut.interactor = marsRoverBusinessLogicSpy
        loadView()
        let marsPhoto = MarsRover.ListMarsRoverPhotos.ViewModel.MarsRoverPhoto(
            photosUrl: URL(fileURLWithPath: ""))
        let marsRoverPhotos = [marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto,
                               marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto,
                               marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto,
                               marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto, marsPhoto]
        let viewModel = MarsRover.ListMarsRoverPhotos.ViewModel(marsRoverPhotos: marsRoverPhotos)

        //
        // When
        sut.displayMarsPhotosPagination(viewModel: viewModel)

        //
        // Then
        XCTAssertFalse(marsRoverBusinessLogicSpy.paginateMarsRoverPhotosCalled,
                       "Paginate method should not be call if there are more than 20 objects")
    }

    //
    // TODO: Test mainLoadingViewOutlet.hideAndStop call &
    // Test Configure cell
}
