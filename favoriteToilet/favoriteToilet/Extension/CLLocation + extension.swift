//
//  CLLocation + extension.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import CoreLocation.CLLocation

extension CLLocation {
    func toCooldinate() -> Coordinate {
        return Coordinate(latitude: self.coordinate.latitude,
                          longitude: self.coordinate.longitude)

    }
}
