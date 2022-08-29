//
//  Marker.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/02.
//

import MapKit

final class Marker: NSObject, MKAnnotation {
    let id: UUID
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(toilet: Toilet) {
        self.id = toilet.id
        self.title = toilet.name
        self.subtitle = toilet.address
        self.coordinate = CLLocationCoordinate2D(latitude: toilet.coordinate.latitude,
                                                 longitude: toilet.coordinate.longitude)
    }
}
