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
    let loadToilet = PublishRelay<Toilet>()
    let loadComments = PublishRelay<[Comment]>()

    init() {
        bind()
    }
}

extension DetailViewModel {
    func bind() {
        let requestComment = loadToilet
            .withUnretained(self)
            .flatMapLatest { model, _ -> Observable<CommentsEntity> in
                model.networkManager.requestComments()}
            .share()

        requestComment
            .subscribe(onNext: {[weak self] entity in
                let comments = entity.data.map { $0.toDomain() }
                self?.loadComments.accept(comments)
            }, onError: { error in
                // MARK: - TODO : Error Handling
            })
            .disposed(by: disposeBag)
    }
}

extension DetailViewModel {
    func configure(with toilet: Toilet) {
        loadToilet.accept(toilet)
    }
}
