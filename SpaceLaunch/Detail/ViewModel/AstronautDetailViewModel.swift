//
//  AstronautDetailViewModel.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 17/8/21.
//

import Foundation
import RxSwift

final class AstronautDetailViewModel {

    private let dataFetcher: DataFetcherProtocol
    private let modelId: Int
    private let astronautDetailsSubject = BehaviorSubject<AstronautDetailModel?>(value: nil)
    private let disposeBag = DisposeBag()
    
    var astronautDetails: Observable<AstronautDetailModel?> {
        astronautDetailsSubject.asObservable()
    }

    init(modelId: Int,
         dataFetcher: DataFetcherProtocol = DataFetcher.shared) {
        self.modelId        =   modelId
        self.dataFetcher    =   dataFetcher
    }
    
    func onViewDidLoad() {
        fetchAstronautsDetail()
    }
}

private extension AstronautDetailViewModel {
    func fetchAstronautsDetail() {
        dataFetcher.getDataFromUrl(urlString: Constants.astronautDetails(id: self.modelId))
            .map { data -> AstronautDetailModel in
                let astronautDetailResponse: AstronautDetailModel = try JSONDecoder().decode(AstronautDetailModel.self, from: data)
                return astronautDetailResponse
            }
            .subscribe(onNext: {self.astronautDetailsSubject.onNext($0)}, onError: { print($0.localizedDescription)})
            .disposed(by: disposeBag)
    }
}


