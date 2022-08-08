//
//  StarRateView.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/03.
//

import UIKit
import SnapKit

final class StarRateView: UIView {

    private lazy var visibleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.alpha = 0.5
        return view
    }()

    private lazy var backgroundView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        (0...4).forEach { _ in
            let configuration = UIImage.SymbolConfiguration(pointSize: 30)
            let image = UIImage(systemName: "star", withConfiguration: configuration)
            var imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .systemYellow
            stackView.addArrangedSubview(imageView)
        }
        return stackView
    }()

    private lazy var foregroundView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        (0...4).forEach { _ in
            let configuration = UIImage.SymbolConfiguration(pointSize: 30)
            let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
            var imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
        }
        return stackView
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resizeForground(touch: touches.first)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        resizeForground(touch: touches.first)
    }

    override func draw(_ rect: CGRect) {
        visibleView.mask = foregroundView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutVisibleView()
        layoutBackgroundView()
        layoutForegroundView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutVisibleView()
        layoutBackgroundView()
        layoutForegroundView()
    }

    private func resizeForground(touch: UITouch?) {
        guard let xPosition = touch?.location(in: self).x as? CGFloat else { return }

        visibleView.snp.updateConstraints { make in
            make.width.equalTo(xPosition)
        }
    }
}

// MARK: - Layout Section

private extension StarRateView {
    func layoutVisibleView() {
        addSubview(visibleView)

        visibleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(0)
            make.top.bottom.equalToSuperview()
        }
    }

    func layoutForegroundView() {
        addSubview(foregroundView)

        foregroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constraint.max)
        }
    }

    func layoutBackgroundView() {
        addSubview(backgroundView)

        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constraint.max)
        }
    }
}
