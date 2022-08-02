//
//  MapViewDelegate.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/29.
//

import MapKit
import RxRelay
import RxSwift

final class MapViewDelegate: NSObject, MKMapViewDelegate {

    private let disposeBag = DisposeBag()
    let didLoadToilets = PublishRelay<ToiletMapEntity>()
    let didCreateMarker = PublishRelay<[Marker]>()

    override init() {
        super.init()
        subscribe()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            btn.addAction(UIAction { _ in
                // MARK: - TODO Pin Touch Action
            }, for: .touchUpInside)
            return annotationView
        }
    }
}

// MARK: - Subscribe

private extension MapViewDelegate {
    func subscribe() {
        didLoadToilets
            .bind(onNext: createMarker)
            .disposed(by: disposeBag)
    }

    func createMarker(_ markerInform: ToiletMapEntity?) {
        let markers = markerInform?.compactMap { (information) -> Marker? in
            let title = information.name
            let subtitle = information.address
            guard let latitude = information.latitude else { return nil }
            guard let longitude = information.longitude else { return nil }
            let newMarker = Marker(title: title,
                                   subtitle: subtitle,
                                   coordinate: CLLocationCoordinate2D(latitude: latitude,
                                                                      longitude: longitude))
            return newMarker
        }
        guard let markers = markers else { return }
        didCreateMarker.accept(markers)
    }
}
