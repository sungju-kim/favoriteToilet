//
//  LogInViewModel.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/29.
//

import Foundation
import AuthenticationServices
import RxSwift
import RxRelay

final class LogInViewModel {
    private let disposeBag = DisposeBag()

    let buttonViewModel = ButtonViewModel()
    let signInDelegate = SignInDelegate()

    let viewDidLoad = PublishRelay<Void>()
    let isAuthorized = PublishRelay<Bool>()
    let loadUserID = PublishRelay<String>()
    let didCreateDelegate = PublishRelay<SignInDelegate>()
    init() {
        bind()
    }
}

// MARK: - Bind

private extension LogInViewModel {
    func bind() {
        signInDelegate.didLoadUserID
            .bind(to: loadUserID)
            .disposed(by: disposeBag)

        loadUserID
            .do { UserDefaults.standard.set($0, forKey: "userID") }
            .map { _ in }
            .bind(onNext: checkAuthorize)
            .disposed(by: disposeBag)

        isAuthorized
            .bind(to: buttonViewModel.isAuthorized)
            .disposed(by: disposeBag)

        viewDidLoad
            .bind(onNext: checkAuthorize)
            .disposed(by: disposeBag)
    }

    func checkAuthorize() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userId = UserDefaults.standard.string(forKey: "userID") ?? ""

        appleIDProvider.getCredentialState(forUserID: userId) { [weak self] state, _ in
            self?.isAuthorized.accept(state == .authorized)
        }
    }
}
