//
//  ToiletMapEntity.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation

typealias ToiletMapEntity = [ToiletEntity]

struct ToiletEntity: Codable {
    let id: UUID
    let type: String
    let name: String
    let openTime: String
    let address, oldAddress: String?
    let latitude, longitude: Double?
}
