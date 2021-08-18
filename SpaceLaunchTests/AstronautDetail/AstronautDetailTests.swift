//
//  AstronautDetailTests.swift
//  SpaceLaunchTests
//
//  Created by Shahjahan Rana on 17/8/21.
//

import XCTest
import RxBlocking
import RxSwift
@testable import SpaceLaunch

class AstronautDetailTests: XCTestCase {

    private var sut: AstronautDetailViewModel!
    private var mockDataFetcher: DataFetcherMock!
    
    override func setUpWithError() throws {
        mockDataFetcher = DataFetcherMock()
        self.sut = AstronautDetailViewModel(modelId: 1,
                                            dataFetcher: mockDataFetcher)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.mockDataFetcher = nil
    }

    func testOnViewDidLoadAstronautDetailsCorrectly() {
        // Given
        let astronautDetailModel = AstronautDetailModel(name: "Abc",
                                                        nationality: nil,
                                                        date_of_birth: nil,
                                                        profile_image: nil,
                                                        bio: nil)
        mockDataFetcher.getDataFromUrlData = try! JSONEncoder().encode(astronautDetailModel)
        
        // When
        sut.onViewDidLoad()
        
        // Then
        XCTAssertEqual(try! sut.astronautDetails.toBlocking().first(), astronautDetailModel)
    }

}
