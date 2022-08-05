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
    private var toiltes: [UUID: Toilet] = [:]
    subscript(id: UUID) -> Toilet? {
        return toiltes[id]
    }

    @NetworkInjector(keypath: \.locationRepository)
    private var locationManager: LocationRepository

    @NetworkInjector(keypath: \.mapViewRepository)
    private var networkManager: MockMapViewRepository

    private let disposeBag = DisposeBag()
    let loadData = PublishRelay<Void>()
    let didLoadLocation = PublishRelay<CLLocationCoordinate2D>()
    let didLoadToilets = PublishRelay<[Toilet]>()

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
                let domains = entity.compactMap { $0.toDomain() }

                domains.forEach {[weak self] toilet in
                    self?.toiltes[toilet.id] = toilet
                }
                self?.didLoadToilets.accept(domains)
            }, onError: { error in
                // MARK: - TODO : Error Handling
            })
            .disposed(by: disposeBag)

        locationManager.didLoadLocation
            .bind(to: didLoadLocation)
            .disposed(by: disposeBag)
    }
}
