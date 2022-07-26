//
//  LogInViewController.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit
import SnapKit

final class LogInViewController: UIViewController {

    private lazy var sloganLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.spacing = Constraint.max

        return stackView
    }()

    private lazy var appleLogInButton: UIButton = {
        let image = UIImage(systemName: "applelogo")
        let button = UIButton.filledButton(Constant.LogInView.appleLogIn, image)
        let action = UIAction {[weak self] _ in
            // MARK: - TODO: Apple OAuth 인증

            self?.appleLogInButton.isHidden = true
            self?.findButton.isHidden = false
        }
        button.addAction(action, for: .touchUpInside)
        button.alpha = 0
        return button
    }()

    private lazy var findButton: UIButton = {
        let button = UIButton.plainButton(Constant.LogInView.findToilet)
        let action = UIAction { _ in
            // MARK: - TODO: mapView로 화면전환
        }
        button.addAction(action, for: .touchUpInside)
        button.isHidden = true
        return button
    }()

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

// MARK: - Configure

private extension LogInViewController {
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
