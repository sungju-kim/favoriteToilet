//
//  LocationRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import MapKit
import RxRelay

final class LocationRepository: NSObject, CLLocationManagerDelegate {
    let didLoadLocation = PublishRelay<CLLocationCoordinate2D>()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func updateLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        didLoadLocation.accept(location.coordinate)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = manager.location else { return }
        didLoadLocation.accept(location.coordinate)
    }
}
