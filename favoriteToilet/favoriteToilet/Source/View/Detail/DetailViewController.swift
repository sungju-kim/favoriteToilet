//
//  DetailViewController.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/03.
//

import UIKit
import SnapKit
import RxSwift

final class DetailViewController: UIViewController {

    private var disposeBag = DisposeBag()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay.bold(40)
        label.numberOfLines = 0
        label.textColor = .Custom.text
        label.textAlignment = .left
        return label
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = Constraint.min
        return stackView
    }()

    private lazy var starRate = StarRateView()

    private lazy var userComment: UITextField = {
        let textField = UITextField()

        textField.font = .SFProText.regular(18)
        textField.placeholder = "한줄평을 입력해주세요"
        textField.textColor = .Custom.text

        var config = UIButton.Configuration.filled()
        config.title = "입력"
        let button = UIButton.init(configuration: config)
        button.addAction(UIAction { _ in
            // MARK: - TODO: userComment 전달 로직
            self.userComment.text = ""
        }, for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
        return textField
    }()

    private let commentsDataSource = CommentsDataSource()
    private lazy var commentsCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(section: commentsDataSource.section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
        collectionView.dataSource = commentsDataSource
        collectionView.allowsSelection = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layoutTitleLabel()
        layoutInformationStackView()
        layoutStarRate()
        layoutUserComment()
        layoutCommentTableView()
    }

    private func showInformation(_ toilet: Toilet) {
        titleLabel.text = toilet.name
        toilet.information.forEach {
            let label = UILabel()
            label.text = $0.contents
            label.font = .SFProDisplay.regular(18)
            informationStackView.addArrangedSubview(label)
        }
    }

    private func showComments(_ comments: [Comment]) {
        commentsDataSource.configure(with: comments)
    }
}

// MARK: - Configure

extension DetailViewController {
    func configure(with viewModel: DetailViewModel) {
        viewModel.loadToilet
            .bind(onNext: showInformation)
            .disposed(by: disposeBag)

        viewModel.loadComments
            .bind(onNext: showComments)
            .disposed(by: disposeBag)
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

    func layoutUserComment() {
        view.addSubview(userComment)

        userComment.snp.makeConstraints { make in
            make.top.equalTo(starRate.snp.bottom).offset(Constraint.min)
            make.leading.trailing.equalToSuperview().inset(Constraint.max)
        }
    }

    func layoutCommentTableView() {
        view.addSubview(commentsCollectionView)

        commentsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constraint.min)
            make.top.equalTo(userComment.snp.bottom).offset(Constraint.min)
        }
    }
}
