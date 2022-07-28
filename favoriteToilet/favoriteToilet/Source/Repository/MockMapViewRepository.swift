//
//  MockMapViewRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/28.
//

import Foundation
import RxSwift

final class MockMapViewRepository: RequestProtocol {
    func request<T: Decodable>(endPoint: Requestable) -> Observable<T> {
        return Observable.create { observer in
            let filename = "publicToilet.json"
            guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
                observer.onError(NetworkError.emptyData)
                return Disposables.create {}
            }
            guard let data = try? Data(contentsOf: file) else {
                observer.onError(NetworkError.emptyData)
                return Disposables.create {}
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                observer.onError(NetworkError.failToDecode)
                return Disposables.create {}
            }
            observer.onNext(decodedData)
            observer.onCompleted()

            return Disposables.create()
        }
    }
}
