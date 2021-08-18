//
//  DataFetcher.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import Foundation
import UIKit
import RxSwift

enum DataFetchError: Error {
    case invalidUrl
}

protocol DataFetcherProtocol {
    func getDataFromUrl(urlString: String) -> Observable<Data>
}

final class DataFetcher: DataFetcherProtocol {
    static let shared = DataFetcher()
    private let session = URLSession(configuration: .default)

    fileprivate init() {}
    
    func getDataFromUrl(urlString: String) -> Observable<Data> {
        guard let dataUrl = URL(string: urlString) else {
            return Observable.error(DataFetchError.invalidUrl)
        }

        return URLSession.shared.rx.data(request: URLRequest(url: dataUrl))
    }
}
