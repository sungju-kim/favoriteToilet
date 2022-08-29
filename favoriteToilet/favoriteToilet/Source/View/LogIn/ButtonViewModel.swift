//
//  ButtonViewModel.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/29.
//

import Foundation
import RxSwift
import RxRelay

final class ButtonViewModel {
    private let disposeBag = DisposeBag()

    let isAuthorized = PublishRelay<Bool>()
    let appleLogInButtonIsHidden = PublishRelay<Bool>()
    let findButtonIsHidden = PublishRelay<Bool>()

    init() {
        bind()
    }
}

private extension ButtonViewModel {
    func bind() {
        isAuthorized
            .bind(to: appleLogInButtonIsHidden)
            .disposed(by: disposeBag)

        isAuthorized
            .map { !$0 }
            .bind(to: findButtonIsHidden)
            .disposed(by: disposeBag)
    }
}
