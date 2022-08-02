//
//  Constant.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import Foundation

struct Constant {
    private init() {}
    // MARK: - LogInView
    enum LogInView {
        static let slogan = "달라진것은 단 하나,\n화장실 입니다."
        static let appleLogIn = "Apple 계정으로 로그인"
        static let findToilet = "화장실 찾기"
    }

    enum MapView {
        static let range = 3000.0
        static let delta = 0.01
    }
}
