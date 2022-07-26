//
//  UIFont + extension.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit.UIFont

extension UIFont {
    enum SFProDisplay {
        static let bold: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProDisplay-Bold", size: size)
        }

        static let semiBold: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProDisplay-Semibold", size: size)
        }

        static let regular: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProDisplay-Regular", size: size)
        }
    }

    enum SFProText {
        static let regular: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProText-Regular", size: size)
        }
    }
}
