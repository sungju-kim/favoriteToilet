//
//  MapViewModel.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa
import CoreLocation

final class MapViewModel {
    @NetworkInjector(keypath: \.locationRepository)
    private var locationManager: LocationRepository

    @NetworkInjector(keypath: \.mapViewRepository)
    private var networkManager: MockMapViewRepository

    private let disposeBag = DisposeBag()
    let loadData = PublishRelay<Void>()
    let didLoadLocation = PublishRelay<CLLocationCoordinate2D>()
    let didLoadToilets = PublishRelay<ToiletMapEntity>()

    init() {
        subscribe()
    }
}

// MARK: - Subscribe

private extension MapViewModel {
    func subscribe() {
        let requestData = loadData
            .withUnretained(self)
            .flatMapLatest { model, _ -> Single<ToiletMapEntity> in
                model.networkManager.request(endPoint: MockEndPoint())
            }
            .share()

        requestData
            .subscribe(onNext: {[weak self] entity in
                self?.didLoadToilets.accept(entity)
            }, onError: { error in
                // MARK: - TODO : Error Handling
            })
            .disposed(by: disposeBag)

        locationManager.didLoadLocation
            .bind(to: didLoadLocation)
            .disposed(by: disposeBag)
    }
}
