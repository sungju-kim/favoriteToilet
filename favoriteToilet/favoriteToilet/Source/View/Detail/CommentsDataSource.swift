//
//  CommentsDataSource.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/08.
//

import UIKit
import RxSwift
import RxRelay

final class CommentsDataSource: NSObject, UICollectionViewDataSource {
    private var comments: [Comment] = []

    private let disposeBag = DisposeBag()
    let updateComments = PublishRelay<Comments>()
    let didLoadComment = PublishRelay<Void>()
    override init() {
        super.init()
        bind()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier,
                                                       for: indexPath) as? CommentCell else { return UICollectionViewCell() }
        let comment = comments[indexPath.item]
        cell.configure(with: comment)
        return cell
    }
}

// MARK: - Providing Function

extension CommentsDataSource {
    var section: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constraint.min
        return section
    }
}

// MARK: - Bind

private extension CommentsDataSource {
    func bind() {
        updateComments
            .map { self.comments = $0.data }
            .bind(to: didLoadComment)
            .disposed(by: disposeBag)
    }
}
