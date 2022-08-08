//
//  CommentCell.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/08.
//

import UIKit

final class CommentCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
    private lazy var userIDLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Custom.userID
        label.font = .SFProDisplay.bold(20)
        return label
    }()

    private lazy var starRateLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Custom.text
        label.font = .SFProText.regular(16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUserIDLabel()
        layoutContentsView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutUserIDLabel()
        layoutContentsView()
    }
}

// MARK: - Layout Section

private extension CommentCell {
    func layoutUserIDLabel() {
        contentView.addSubview(userIDLabel)

        userIDLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }

    func layoutContentsView() {
        contentView.addSubview(contentLabel)

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(userIDLabel.snp.bottom).offset(Constraint.min)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Providing Function

extension CommentCell {
    func configure(with comment: Comment) {
        self.userIDLabel.text = comment.writer
        self.contentLabel.text = comment.contents
    }
}
