//
//  LocationRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import MapKit

final class LocationRepository: NSObject, CLLocationManagerDelegate {

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
        let CLCoordinate = location.coordinate
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
        loadedLocation.accept(coordinate)
    }
}
