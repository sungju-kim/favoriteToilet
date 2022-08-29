//
//  NetworkRepository.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/29.
//

import Foundation
import RxSwift
import Alamofire

class NetworkRepository<Target: Requestable> {
    let networkManager = NetworkManager<Target>()

    static func decode<T: Decodable>(_ type: T.Type, decodeTarget data: Data?) -> T? {
        guard let data = data,
              let decodedData = try? JSONDecoder().decode(type.self, from: data) else {
            return nil
        }
        return decodedData
    }
}
