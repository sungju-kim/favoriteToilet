//
//  MockMapViewRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/28.
//

import Foundation
import RxSwift

final class MockMapViewRepository: RequestProtocol {
    func request<T: Decodable>(endPoint: Requestable) -> Single<T> {
        return Single.create { observer in
            let filename = "publicToilet.json"
            guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
                observer(.failure(NetworkError.emptyData))
                return Disposables.create {}
            }
            guard let data = try? Data(contentsOf: file) else {
                observer(.failure(NetworkError.emptyData))
                return Disposables.create {}
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                observer(.failure(NetworkError.failToDecode))
                return Disposables.create {}
            }
            observer(.success(decodedData))
            return Disposables.create()
        }
    }
}
