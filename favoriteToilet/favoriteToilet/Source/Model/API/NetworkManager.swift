//
//  NetworkManager.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation
import RxSwift
import Alamofire

class NetworkManager: RequestProtocol {
    private init() {}

    func request<T: Decodable>(endPoint: Requestable) -> Observable<T> {
        return Observable.create { observer in
            guard let url = endPoint.url else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create {}
            }

            let headers: HTTPHeaders = endPoint.headers

            let request: DataRequest = AF.request(url,
                                                  method: endPoint.method,
                                                  parameters: endPoint.parameter,
                                                  headers: headers)

            request
                .validate(statusCode: 200..<300)
                .response { response in
                    guard let data = response.data else {
                        observer.onError(NetworkError.emptyData)
                        return
                    }
                    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                        observer.onError(NetworkError.failToDecode)
                        return
                    }
                    observer.onNext(decodedData)
                    observer.onCompleted()
                }
            return Disposables.create {}
        }
    }
}

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
