//
//  NetworkContainer.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation

final class NetworkContainer {
    private init() {}
    static var shared = NetworkContainer()

    lazy var locationRepository = LocationRepository()
    lazy var mapViewRepository = MockMapViewRepository()
    lazy var detailViewRepository = MockDetailViewRepository()
}
