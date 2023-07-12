//
//  ProductDetailViewController.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

class BannerProductDetailViewController: UIViewController {

	private lazy var backButton: UIButton = {
		var button = UIButton()
		button.setTitle("X", for: .normal)
		button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
		button.backgroundColor = .lightGray
		button.layer.cornerRadius = 30
		return button
	}()

	@objc func dismissView() {
		self.presentingViewController?.dismiss(animated: true)
	}

	private lazy var contentStackView: UIStackView = {
		var stackView = UIStackView(arrangedSubviews: [detailBannerImageView, titleStackView, detailDescriptionLabel])
		stackView.alignment = .leading
		stackView.axis = .vertical
		stackView.spacing = 12
		return stackView
	}()

	private lazy var detailBannerImageView: UIImageView = {
		var imageView = UIImageView()
		return imageView
	}()

	private lazy var titleStackView: UIStackView = {
		var stackView = UIStackView(arrangedSubviews: [detailIconImageView, detailTitleLabel])
		stackView.alignment = .fill
		stackView.axis = .horizontal
		stackView.spacing = 12
		return stackView
	}()

	private lazy var detailIconImageView: UIImageView = {
		var imageView = UIImageView()
		return imageView
	}()

	private lazy var detailTitleLabel: UILabel = {
		var label = UILabel()
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		return label
	}()

	private lazy var detailDescriptionLabel: UILabel = {
		var label = UILabel()
		label.font = .systemFont(ofSize: 16, weight: .medium)
		label.numberOfLines = 0
		return label
	}()

	convenience init(detail: ProductDetail) {
		self.init()
		setup(with: detail)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupLayout()
	}

	private func setupView() {
		view.backgroundColor = .white
	}

	private func setupLayout() {

		view.addSubview(backButton, constraints: [
			backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12)
		])

		view.addSubview(contentStackView, constraints: [
			contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
			contentStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 8)
		])

		detailIconImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
		detailIconImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
	}

	private func setup(with detail: ProductDetail) {
		detailTitleLabel.text = detail.title
		detailDescriptionLabel.text = detail.description
		detailBannerImageView.setImage(from: detail.imageURL)
		if detail.isBanner {
			detailBannerImageView.setImage(from: detail.imageURL)
			detailIconImageView.isHidden = true
			detailBannerImageView.isHidden = false
		} else {
			detailIconImageView.setImage(from: detail.imageURL)
			detailIconImageView.isHidden = false
			detailBannerImageView.isHidden = true
		}
	}
}
