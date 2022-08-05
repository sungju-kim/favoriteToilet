//
//  Toilet.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation

struct Toilet {
    let id: UUID
    let name: String
    let address: String
    let coordinate: Coordinate
    var starRate: StarRate
    let information: [Information]
}
