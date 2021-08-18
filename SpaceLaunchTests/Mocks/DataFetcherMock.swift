//
//  DataFetcherMock.swift
//  SpaceLaunchTests
//
//  Created by Shahjahan Rana on 16/8/21.
//

import Foundation
import RxSwift
@testable import SpaceLaunch

final class DataFetcherMock: DataFetcherProtocol {
    var getDataFromUrlData: Data!
    func getDataFromUrl(urlString: String) -> Observable<Data> {
        return Observable.just(getDataFromUrlData)
    }
}
