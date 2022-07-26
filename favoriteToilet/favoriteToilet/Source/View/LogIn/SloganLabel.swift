//
//  SloganLabel.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit

class SloganLabel: UILabel {
    convenience init(text: String) {
        self.init()
        font = .SFProDisplay.semiBold(40)
        textColor = .darkGray
        alpha = 0
        self.text = text
    }
}
