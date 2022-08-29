//
//  NetworkManager.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation
import RxSwift
import Alamofire

class NetworkManager<Target: Requestable> {

    func request(endPoint: Target) -> Single<Data> {
        return Single.create { observer in
            guard let url = endPoint.url else {
                observer(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }

            let request: DataRequest = AF.request(url,
                                                  method: endPoint.method,
                                                  parameters: endPoint.parameter)
            request
                .validate(statusCode: 200..<300)
                .response { response in
                    if let data = response.data {
                        observer(.success(data))
                    } else {
                        observer(.failure(NetworkError.emptyData))
                    }
                }
            return Disposables.create()
        }
    }

}
