//
//  SpotlightBannerCell.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

final class SpotlightBannerCell: UICollectionViewCell {
	
	private lazy var containerView: ShadowView = {
		let view = ShadowView(frame: .zero, cornerRadius: 30)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	private lazy var bannerImageView: UIImageView = {
		var imageView = UIImageView()
		imageView.layer.cornerRadius = 30
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
			containerView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
		])
		containerView.addSubview(bannerImageView, constraints: [
			bannerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
			bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
		])
	}
	
	func setupBanner(url: String) {
		bannerImageView.setImage(from: url)
	}
}
