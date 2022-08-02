//
//  MockEndPoint.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/29.
//

import Foundation
import Alamofire

struct MockEndPoint: Requestable {
    private(set) var baseURL: URL? = URL(string: "")
    private(set) var path: String = ""
    private(set) var url: URL? = URL(string: "")
    private(set) var headers: HTTPHeaders = HTTPHeaders()
    private(set) var parameter: [String: String] = [:]
    private(set) var method: HTTPMethod = HTTPMethod(rawValue: "")
}
