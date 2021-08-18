//
//  DataFetcher.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import RxSwift
import UIKit

public
protocol ImageFetcherProtocol {
    func getImageFromURL(urlString: String) -> Observable<UIImage?>
}

class ImageFetcher: ImageFetcherProtocol {
    static let shared = ImageFetcher()
    private let session = URLSession(configuration: .default)

    fileprivate init() {}

    func getImageFromURL(urlString: String) -> Observable<UIImage?> {
        guard let imageUrl = URL(string: urlString) else { return Observable.just(nil) }

        return URLSession.shared.rx.data(request: URLRequest(url: imageUrl))
            .map { UIImage(data: $0) }
            .observe(on: MainScheduler.instance)
    }
}
