//
//  MapViewController.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    private var viewModel: MapViewModel?
    private lazy var mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutMapView()
    }
}

// MARK: - Layout Section

private extension MapViewController {
    func layoutMapView() {
        view.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.edges.equalTo(super.view.safeAreaLayoutGuide).inset(Constraint.min)
        }
    }
}

// MARK: - Configure

extension MapViewController {
    func configure(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
}
