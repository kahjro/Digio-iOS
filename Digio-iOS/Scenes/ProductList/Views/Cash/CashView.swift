//
//  CashView.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

protocol CashBannerDelegate: AnyObject {
	func cashClicked(_ detail: Cash)
}

final class CashView: UIView {
	
	private weak var delegate: CashBannerDelegate?
	private var cashDetails: Cash?
	
	private lazy var containerView: ShadowView = {
		let view = ShadowView(frame: .zero, cornerRadius: 30)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	private lazy var cashTitleLabel: UILabel = {
		var label = UILabel()
		let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1188358739, green: 0.1861418486, blue: 0.2863286436, alpha: 1)]

		let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.5529411435, green: 0.5529412031, blue: 0.5529411435, alpha: 1)]

			let attributedString1 = NSMutableAttributedString(string:"digio", attributes:attrs1)

			let attributedString2 = NSMutableAttributedString(string:" Cash", attributes:attrs2)

			attributedString1.append(attributedString2)
			label.attributedText = attributedString1
		return label
	}()
	
	private lazy var cashBannerImageView: UIImageView = {
		var imageView = UIImageView()
		imageView.layer.cornerRadius = 10
		imageView.clipsToBounds = true
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupAction()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup(cash: Cash, delegate: CashBannerDelegate) {
		setupBanner(url: cash.bannerURL)
		cashDetails = cash
		self.delegate = delegate
	}
	
	private func setupAction() {
		let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.bannerClicked))
		self.cashBannerImageView.addGestureRecognizer(gesture)
	}
	
	@objc func bannerClicked(sender : UITapGestureRecognizer) {
		guard let details = cashDetails else { return }
		delegate?.cashClicked(details)
	}
	
	private func setupBanner(url: String) {
		cashBannerImageView.setImage(from: url)
	}
	
	private func setupLayout() {
		addSubview(cashTitleLabel, constraints: [
			cashTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			cashTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8)
		])
		
		addSubview(containerView, constraints: [
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			containerView.topAnchor.constraint(equalTo: cashTitleLabel.bottomAnchor, constant: 8),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			containerView.heightAnchor.constraint(equalToConstant: 100)
		])
		
		containerView.addSubview(cashBannerImageView, constraints: [
			cashBannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			cashBannerImageView.topAnchor.constraint(equalTo: cashTitleLabel.bottomAnchor, constant: 8),
			cashBannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			cashBannerImageView.heightAnchor.constraint(equalToConstant: 100)
			
		])
	}
	
}
