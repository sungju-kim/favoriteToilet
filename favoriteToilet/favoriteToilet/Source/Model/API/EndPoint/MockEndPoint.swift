//
//  MockEndPoint.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/29.
//

import Foundation
import Alamofire

enum MockEndPoint {
    case toilets
    case comments
}

extension MockEndPoint: Requestable {
    var baseURL: URL? {
        return URL(string: "http://localhost:3000/")
    }
    var path: String {
        switch self {
        case .toilets:
            return "toilets"
        case .comments:
            return "comments"
        }
    }
    var url: URL? {
        return baseURL?.appendingPathComponent(path)
    }
    var headers: HTTPHeaders {
        return [HTTPHeader.accept("application/json")]
    }

    var parameter: [String: String] {
        switch self {
        default:
            return [:]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .toilets, .comments:
            return .get
        }
    }
}
