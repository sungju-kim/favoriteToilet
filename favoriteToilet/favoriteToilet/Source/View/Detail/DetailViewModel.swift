//
//  DetailViewModel.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/05.
//

import Foundation
import MapKit
import RxRelay
import RxSwift

final class DetailViewModel {

    @NetworkInjector(keypath: \.detailViewRepository)
    private var networkManager: MockDetailViewRepository

    private var disposeBag = DisposeBag()
    let viewDidLoad = PublishRelay<Void>()
    let didLoadToilet = PublishRelay<Toilet>()
    let didLoadComments = PublishRelay<Comments>()

    init(toilet: Toilet) {
        viewDidLoad
            .map { toilet }
            .bind(to: didLoadToilet)
            .disposed(by: disposeBag)

        Observable.combineLatest(viewDidLoad.asObservable(), networkManager.requestComments())
            .map { $1.toDomain() }
            .bind(to: didLoadComments)
            .disposed(by: disposeBag)
    }
}
