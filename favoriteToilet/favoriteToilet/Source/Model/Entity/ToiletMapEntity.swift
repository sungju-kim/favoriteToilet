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

extension ToiletEntity {
    func toDomain() -> Toilet? {
        guard let latitude = latitude,
              let longitude = longitude else { return nil }
        if let address = address {
            return Toilet(id: id,
                   name: name,
                   address: address,
                   coordinate: Coordinate(latitude: latitude, longitude: longitude),
                   starRate: StarRate(averageRate: 5.0),
                          information: [Information(contents: type),
                                        Information(contents: openTime)])
        }

        if let oldAddress = oldAddress {
            return Toilet(id: id,
                   name: name,
                   address: oldAddress,
                   coordinate: Coordinate(latitude: latitude, longitude: longitude),
                   starRate: StarRate(averageRate: 5.0),
                          information: [Information(contents: type),
                                        Information(contents: openTime)])

        }
        return nil
    }
}
