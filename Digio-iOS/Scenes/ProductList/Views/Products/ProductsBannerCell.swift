//
//  ProductsBannerCell.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

final class ProductsBannerCell: UICollectionViewCell {

	private lazy var containerView: ShadowView = {
		let view = ShadowView(frame: .zero, cornerRadius: 20)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()

	private lazy var bannerImageView: UIImageView = {
		var imageView = UIImageView()
		imageView.clipsToBounds = true
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		bannerImageView.image = nil
	}

	private func setupLayout() {
		addSubview(containerView, constraints: [
			containerView.topAnchor.constraint(equalTo: topAnchor),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])

		containerView.addSubview(bannerImageView, constraints: [
			bannerImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			bannerImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			bannerImageView.heightAnchor.constraint(equalToConstant: 60),
			bannerImageView.widthAnchor.constraint(equalToConstant: 60)

		])
	}

	func setupBanner(url: String) {
		bannerImageView.setImage(from: url)
	}
}
