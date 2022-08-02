//
//  RequestProtocol.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation
import RxSwift

protocol RequestProtocol {
    func request<T: Decodable>(endPoint: Requestable) -> Single<T>
}
