//
//  StarRateLabel.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/08.
//

import UIKit

class StarRateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Providing Function

extension StarRateLabel {
    func setUserRate(rate: Double) {
        let attributedString = NSMutableAttributedString(string: "\(rate) / 5.0")
        let image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        let imageString = NSMutableAttributedString(attachment: imageAttachment)
        imageString.append(attributedString)
        self.attributedText = imageString
        self.font = .SFProDisplay.regular(10)
    }
}
