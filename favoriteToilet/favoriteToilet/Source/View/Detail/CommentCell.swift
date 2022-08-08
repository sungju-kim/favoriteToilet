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
        label.font = .SFProDisplay.bold(18)
        return label
    }()

    private lazy var starRateLabel = StarRateLabel()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Custom.text
        label.font = .SFProText.regular(16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUserIDLabel()
        layoutStarRateLabel()
        layoutContentsView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutUserIDLabel()
        layoutStarRateLabel()
        layoutContentsView()
    }
}

// MARK: - Layout Section

private extension CommentCell {
    func layoutUserIDLabel() {
        contentView.addSubview(userIDLabel)

        userIDLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
    }

    func layoutStarRateLabel() {
        contentView.addSubview(starRateLabel)

        starRateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userIDLabel.snp.bottom)
            make.leading.equalTo(userIDLabel.snp.trailing).offset(Constraint.min)
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
        self.starRateLabel.setUserRate(rate: comment.starRate)
    }
}
