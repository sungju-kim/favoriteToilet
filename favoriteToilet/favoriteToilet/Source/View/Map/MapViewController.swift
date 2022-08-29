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
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutMapView()
    }
}

// MARK: - Private Function
private extension MapViewController {
    func createAnnotation(_ data: ([Marker], CLLocationCoordinate2D)) {
        let (markers, coordinate) = data
        let viewRange = CLCircularRegion(center: coordinate,
                                         radius: Constant.MapView.range,
                                         identifier: "viewRange")

        markers
            .filter { viewRange.contains($0.coordinate) }
            .forEach { self.mapView.addAnnotation($0) }
    }

    func pushDetailView(_ id: UUID) {
        let detailViewController = DetailViewController()
        guard let toilet = viewModel?[id] else { return }
        let viewModel = DetailViewModel(toilet: toilet)
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

        let coordinate = viewModel.didLoadLocation
            .share()

        coordinate
            .map {
                let spanValue = MKCoordinateSpan(latitudeDelta: Constant.MapView.delta,
                                                 longitudeDelta: Constant.MapView.delta)
                let locationRegion = MKCoordinateRegion(center: $0,
                                                        span: spanValue)
                return (locationRegion, true)
            }
            .bind(onNext: mapView.setRegion)
            .disposed(by: disposeBag)

        viewModel.didLoadToilets
            .bind(to: mapViewDelegate.didLoadToilets)
            .disposed(by: disposeBag)

        Observable.combineLatest(
            mapViewDelegate.didCreateMarker.asObservable(),
            coordinate.asObservable())
        .bind(onNext: createAnnotation)
        .disposed(by: disposeBag)

        mapViewDelegate.didPinTouched
            .bind(onNext: pushDetailView)
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
}
