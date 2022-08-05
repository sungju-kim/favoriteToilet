//
//  CommentEntity.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/05.
//

import Foundation

struct CommentEntity: Codable {
    let id: UUID
    let writer: String
    let contents: String
}

extension CommentEntity {
    func toDomain() -> Comment {
        return Comment(id: id,
                       writer: writer,
                       contents: contents)
    }
}