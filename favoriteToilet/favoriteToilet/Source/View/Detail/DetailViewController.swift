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

    private lazy var starRate = StarRateView()

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
