//
//  MockMapViewRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/28.
//

import Foundation
import RxSwift

protocol MockMapViewRepository {
    func requestToilets() -> Observable<ToiletMapEntity>
}

final class MockMapViewRepositoryImpl: NetworkRepository<MockEndPoint>, MockMapViewRepository {
    private let disposeBag = DisposeBag()

    func requestToilets() -> Observable<ToiletMapEntity> {
        return Observable.create { observer in
            self.networkManager.request(endPoint: .toilets)
                .subscribe { data in
                    guard let decodedData = Self.decode(ToiletMapEntity.self, decodeTarget: data) else {
                        observer.onError(NetworkError.failToDecode)
                        return
                    }
                    observer.onNext(decodedData)
                } onFailure: { error in
                    print(error)
                    observer.onError(NetworkError.emptyData)
                }.disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }
}
