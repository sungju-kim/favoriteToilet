//
//  MockDetailViewRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/05.
//

import Foundation
import RxSwift

protocol MockDetailViewRepository {
    func requestComments() -> Observable<CommentsEntity>
}

final class MockDetailViewRepositoryImpl: NetworkRepository<MockEndPoint>, MockDetailViewRepository {
    private let disposeBag = DisposeBag()

    func requestComments() -> Observable<CommentsEntity> {
        return Observable.create { observer in
            self.networkManager.request(endPoint: .toilets)
                .subscribe { data in
                    guard let decodedData = Self.decode(CommentsEntity.self, decodeTarget: data) else {
                        observer.onError(NetworkError.failToDecode)
                        return
                    }
                    observer.onNext(decodedData)
                } onFailure: { error in
                    print(error)
                    observer.onError(NetworkError.emptyData)
                }.disposed(by: self.disposeBag)

            return Disposables.create {}
        }
    }
}
