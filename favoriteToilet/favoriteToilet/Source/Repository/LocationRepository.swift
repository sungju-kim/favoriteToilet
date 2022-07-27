//
//  LocationRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import MapKit
import RxRelay

final class LocationRepository: NSObject, CLLocationManagerDelegate {
    let didLoadLocation = PublishRelay<Coordinate>()

    private var locations: [CLLocation] = []

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func getUserLoaction() {
        guard let location = self.locations.last else { return }
        let coordinate = location.toCooldinate()
        didLoadLocation.accept(coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if self.locations.count >= 10 {
            self.locations.removeAll()
        }
        self.locations.append(location)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = manager.location else { return }
        let coordinate = location.toCooldinate()
        didLoadLocation.accept(coordinate)
    }
}
