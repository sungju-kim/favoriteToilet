//
//  UIButton + extension.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit.UIButton

extension UIButton {
    static let plainButton: (String) -> UIButton = { title in
        var attribute = AttributedString.init(title)
        attribute.font = .SFProDisplay.semiBold(Constraint.regular)

        var plain = UIButton.Configuration.plain()
        plain.attributedTitle = attribute
        plain.baseForegroundColor = .black

        let button = UIButton(configuration: plain)

        return button
    }

    static let filledButton: (String, UIImage?) -> UIButton = { title, image in
        var attribute = AttributedString.init(title)
        attribute.font = .SFProDisplay.semiBold(Constraint.regular)

        var filled = UIButton.Configuration.filled()
        filled.attributedTitle = attribute
        filled.image = image
        filled.imagePadding = 8
        filled.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 17, bottom: 17, trailing: 17)
        filled.baseBackgroundColor = .black

        let button = UIButton(configuration: filled)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true

        return button
    }
}
