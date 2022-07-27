//
//  NetworkError.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failToDecode
    case emptyData
}
