//
//  DetailViewController.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/03.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay.bold(40)
        label.textColor = .Custom.text
        label.textAlignment = .right
        return label
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var starRate: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        (0...4).forEach { order in
            let button = UIButton()
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.addAction(UIAction { _ in
                stackView.subviews[0...order].forEach { subview in
                    guard let subview = subview as? UIButton else { return }
                    subview.setImage(UIImage(systemName: "star.fill"), for: .normal)
                }
                stackView.subviews[(order+1)...].forEach { subview in
                    guard let subview = subview as? UIButton else { return }
                    subview.setImage(UIImage(systemName: "star"), for: .normal)
                }
            }, for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        return stackView
    }()

    private lazy var commentTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutTitleLabel()
        layoutInformationStackView()
        layoutStarRate()
        layoutCommentTableView()
    }
}

// MARK: - Layout Section

private extension DetailViewController {
    func layoutTitleLabel() {
        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constraint.min)
            make.leading.trailing.equalToSuperview().inset(Constraint.min)
        }
    }

    func layoutInformationStackView() {
        view.addSubview(informationStackView)

        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constraint.min)
            make.leading.trailing.equalToSuperview().inset(Constraint.min)
        }
    }

    func layoutStarRate() {
        view.addSubview(starRate)

        starRate.snp.makeConstraints { make in
            make.top.equalTo(informationStackView.snp.bottom).offset(Constraint.min)
            make.leading.trailing.equalToSuperview().inset(Constraint.min)
        }
    }

    func layoutCommentTableView() {
        view.addSubview(commentTableView)

        commentTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constraint.min)
            make.top.equalTo(starRate.snp.bottom).offset(Constraint.min)
        }
    }
}
