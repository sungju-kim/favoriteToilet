//
//  MapViewModel.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation

final class MapViewModel {
    @NetworkInjector(keypath: \.locationRepository)
    private var locationManager: LocationRepository
}
