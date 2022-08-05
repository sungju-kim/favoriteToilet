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

    init(id: UUID, title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
