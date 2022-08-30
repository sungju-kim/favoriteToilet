//
//  MapViewController.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit
import MapKit
import RxSwift
import RxAppState
import RxCocoa

final class MapViewController: UIViewController {
    private var viewModel: MapViewModel?
    private var disposeBag = DisposeBag()

    private let mapViewDelegate = MapViewDelegate()
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = mapViewDelegate
        mapView.showsUserLocation = true
        mapView.register(ToiletMarkerView.self, forAnnotationViewWithReuseIdentifier: ToiletMarkerView.identifier)
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutMapView()
    }
}

// MARK: - Private Function
private extension MapViewController {
    func createAnnotation(_ data: (CLLocationCoordinate2D, [Marker])) {
        let (coordinate, markers) = data
        let viewRange = CLCircularRegion(center: coordinate,
                                         radius: Constant.MapView.range,
                                         identifier: "viewRange")

        markers
            .filter { viewRange.contains($0.coordinate) }
            .forEach { self.mapView.addAnnotation($0) }
    }

    func pushDetailView(_ viewModel: DetailViewModel) {
        let detailViewController = DetailViewController()
        detailViewController.configure(with: viewModel)

        navigationController?.pushViewController(detailViewController, animated: true)
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

        viewModel.updateLocation
            .map {
                (MKCoordinateRegion(center: $0, span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                      longitudeDelta: 0.01)), true)}
            .bind(onNext: mapView.setRegion)
            .disposed(by: disposeBag)

        viewModel.didLoadMapData
            .bind(onNext: createAnnotation)
            .disposed(by: disposeBag)

        viewModel.prepareForPush
            .bind(onNext: pushDetailView)
            .disposed(by: disposeBag)

        mapViewDelegate.annotationTouched
            .bind(to: viewModel.annotationTouched)
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
}
