//
//  CommentEntity.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/05.
//

import Foundation

struct CommentsEntity: Codable {
    let id: String
    let data: [CommentEntity]
}

struct CommentEntity: Codable {
    let id: UUID
    let writer: String
    let contents: String
    let starRate: Double
}

extension CommentEntity {
    func toDomain() -> Comment {
        return Comment(id: id,
                       writer: writer,
                       contents: contents, starRate: starRate)
    }
}
