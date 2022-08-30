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
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ToiletMarkerView.identifier),
            let annotation = annotation as? Marker else { return nil }
        annotationView.isEnabled = true
        annotationView.annotation = annotation
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
