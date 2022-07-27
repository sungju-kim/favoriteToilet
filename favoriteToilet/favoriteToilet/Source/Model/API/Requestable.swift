//
//  Requestable.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation
import Alamofire

protocol Requestable: Decodable {
    var baseURL: URL? { get }
    var path: String { get }
    var url: URL? { get }
    var headers: HTTPHeaders { get }
    var parameter: [String: String] { get }
    var method: Alamofire.HTTPMethod { get }
}
