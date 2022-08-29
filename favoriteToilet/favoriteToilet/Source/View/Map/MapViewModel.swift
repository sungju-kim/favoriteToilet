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
    let viewDidLoad = PublishRelay<Void>()
    let didLoadLocation = PublishRelay<CLLocationCoordinate2D>()
    let didLoadToilets = PublishRelay<[UUID: Toilet]>()

    let annotationTouched = PublishRelay<UUID>()
    let prepareForPush = PublishRelay<DetailViewModel>()

    init() {
        subscribe()
    }
}

// MARK: - Subscribe

private extension MapViewModel {
    func subscribe() {
        viewDidLoad
            .withUnretained(self)
            .flatMapLatest { model, _ -> Observable<ToiletMapEntity> in
                model.networkManager.requestToilets()}
            .map { $0.reduce(into: [:]) { dict, data in
                dict[data.id] = data.toDomain()}}
            .bind(to: didLoadToilets)
            .disposed(by: disposeBag)

        annotationTouched
            .withLatestFrom(didLoadToilets) { ($0, $1) }
            .compactMap { $1[$0] }
            .map { DetailViewModel(toilet: $0) }
            .bind(to: prepareForPush)
            .disposed(by: disposeBag)

        locationManager.didLoadLocation
            .bind(to: didLoadLocation)
            .disposed(by: disposeBag)
    }
}
