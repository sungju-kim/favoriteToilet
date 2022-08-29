//
//  MapViewDelegate.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/29.
//

import MapKit
import RxRelay
import RxSwift
import RxAppState

final class MapViewDelegate: NSObject, MKMapViewDelegate {

    private let disposeBag = DisposeBag()

    let annotationTouched = PublishRelay<UUID>()

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Marker else { return nil }

        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            btn.rx.tap
                .map {annotation.id}
                .bind(to: annotationTouched)
                .disposed(by: disposeBag)
            return annotationView
        }
    }
}
