//
//  HomeViewModelTests.swift
//  SpaceLaunchTests
//
//  Created by Shahjahan Rana on 17/8/21.
//

import XCTest
import RxBlocking
@testable import SpaceLaunch

class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModel!
    private var mockDataFetcher: DataFetcherMock!
    
    override func setUpWithError() throws {
        mockDataFetcher = DataFetcherMock()
        self.sut = HomeViewModel(dataFetcher: mockDataFetcher)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.mockDataFetcher = nil
    }

    func testOnViewDidLoadSetsDataCorrectly() {
        // Given
        mockDataFetcher.getDataFromUrlData = try! JSONEncoder().encode(AstronautsResponseModel(results: [AstronautModel(id: 1, name: nil, nationality: nil, profile_image_thumbnail: nil)]))
        
        // When
        sut.onViewDidLoad()
        
        // Then
        XCTAssertFalse(try! sut.astronauts.toBlocking().first()?.isEmpty ?? true)
    }
    
    func testOnSortTappedSortSuccessfull() {
        // Given
        mockDataFetcher.getDataFromUrlData = try! JSONEncoder().encode(AstronautsResponseModel(results: [
            AstronautModel(id: 1, name: "XYZ", nationality: nil, profile_image_thumbnail: nil),
            AstronautModel(id: 2, name: "Abc", nationality: nil, profile_image_thumbnail: nil),
        ]))
        sut.onViewDidLoad()

        // When
        sut.onSortTapped()

        // Then
        XCTAssertEqual(try! sut.astronauts.toBlocking().first()?.first?.name, "Abc")
    }

}
