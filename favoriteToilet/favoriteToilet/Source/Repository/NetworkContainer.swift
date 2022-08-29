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

    private (set) lazy var locationRepository = LocationRepository()
    private (set) lazy var mapViewRepository: MockMapViewRepository = MockMapViewRepositoryImpl()
    private (set) lazy var detailViewRepository: MockDetailViewRepository = MockDetailViewRepositoryImpl()
}
