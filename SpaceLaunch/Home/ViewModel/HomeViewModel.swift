//
//  HomeViewModel.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import Foundation
import RxSwift

final class HomeViewModel {

    private let dataFetcher: DataFetcherProtocol
    private let astronautsSubject = BehaviorSubject<[AstronautModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    var astronauts: Observable<[AstronautModel]> {
        astronautsSubject.asObservable()
    }

    init(dataFetcher: DataFetcherProtocol = DataFetcher.shared) {
        self.dataFetcher    =   dataFetcher
    }
    
    func onViewDidLoad() {
        fetchAstronautsList()
    }

    func onSortTapped() {
        let sortedResult: [AstronautModel]?
        do {
            sortedResult = try astronautsSubject.value().sorted { ($0.name ?? "") < ($1.name ?? "") }
        } catch {
            print("Error sorting")
            sortedResult = nil
        }
        if let sortedResult = sortedResult {
            astronautsSubject.onNext(sortedResult)
        }
    }
}

private extension HomeViewModel {
    func fetchAstronautsList() {
        dataFetcher.getDataFromUrl(urlString: getAstronautListURL())
            .map { data -> [AstronautModel] in
                let astronautResponse: AstronautsResponseModel = try JSONDecoder().decode(AstronautsResponseModel.self, from: data)
                return astronautResponse.results ?? []
            }
            .subscribe(onNext: {self.astronautsSubject.onNext($0)}, onError: { print($0.localizedDescription)})
            .disposed(by: disposeBag)
    }
    
    private func getAstronautListURL() -> String {
        return "\(Constants.baseURL)\(Constants.astronautsList)"
    }
}

