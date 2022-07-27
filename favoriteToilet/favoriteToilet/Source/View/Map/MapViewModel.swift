//
//  MapViewModel.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation
import RxRelay

final class MapViewModel {
    @NetworkInjector(keypath: \.locationRepository)
    private var locationManager: LocationRepository

    init() {
        subscribe()
    }
}

// MARK: - Subscribe

private extension MapViewModel {
    func subscribe() {
        _ = locationManager.didLoadLocation.subscribe { coordinate in
            // MARK: - TODO Network request
        }
    }
}
