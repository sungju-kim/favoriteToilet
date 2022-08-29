//
//  LogInViewController.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit
import RxSwift
import RxAppState
import SnapKit
import AuthenticationServices

final class LogInViewController: UIViewController {
    private var viewModel: LogInViewModel?

    private let disposeBag = DisposeBag()

    private lazy var sloganLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.spacing = Constraint.max

        return stackView
    }()

    private var signInDelegate: SignInDelegate?
    private lazy var contextProvider = ContextProvider(window: self.view.window)

    private lazy var appleLogInButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        var action: UIAction = UIAction { _ in
            self.pushToMain()
//            let provider = ASAuthorizationAppleIDProvider()
//            let request = provider.createRequest()
//            request.requestedScopes = [.email, .fullName]
//            let controller = ASAuthorizationController(authorizationRequests: [request])
//            controller.delegate = self.signInDelegate
//            controller.presentationContextProvider = self.contextProvider
//            controller.performRequests()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var findButton: UIButton = UIButton.plainButton(Constant.LogInView.findToilet)

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutSloganLabels()
        layoutAppleLoginButton()
        layoutFindButton()
        fadeInOut()
    }
}

// MARK: - LayoutSection

private extension LogInViewController {
    func layoutSloganLabels() {
        view.addSubview(sloganLabels)

        Constant.LogInView.slogan.components(separatedBy: "\n").forEach {
            sloganLabels.addArrangedSubview(SloganLabel(text: $0))
        }

        sloganLabels.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constraint.min)
        }
    }

    func layoutAppleLoginButton() {
        view.addSubview(appleLogInButton)

        appleLogInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constraint.max * 2)
        }
    }

    func layoutFindButton() {
        view.addSubview(findButton)

        findButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constraint.max * 2)
        }
    }
}

// MARK: Configure

extension LogInViewController {
    func configure(with viewModel: LogInViewModel) {
        self.viewModel = viewModel
        self.signInDelegate = viewModel.signInDelegate

        viewModel.buttonViewModel.appleLogInButtonIsHidden
            .bind(to: appleLogInButton.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.buttonViewModel.findButtonIsHidden
            .bind(to: findButton.rx.isHidden)
            .disposed(by: disposeBag)

        findButton.rx.tap
            .bind(onNext: pushToMain)
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Function

private extension LogInViewController {
    func pushToMain() {
        let tabBarController = MainTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .crossDissolve
        present(tabBarController, animated: true, completion: nil)
    }

    func fadeInOut() {
        sloganLabels.subviews.enumerated().forEach { index, label in
            UIView.animate(withDuration: 1.0, delay: Double(index)/2) {
                label.alpha = 1.0
            }
        }

        UIView.animate(withDuration: 1.0, delay: Double(sloganLabels.subviews.count)/2) { [weak self] in
            self?.appleLogInButton.alpha = 1.0
        }
    }
}
