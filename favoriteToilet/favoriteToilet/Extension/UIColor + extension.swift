//
//  UIColor + extension.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit.UIColor

extension UIColor {
    enum Custom {
        static let backGround = UIColor.systemBackground
        static let textColor: (CGFloat) -> UIColor = { alpha in
            let color = UIColor.black.withAlphaComponent(alpha)
            return color
        }
    }
}
