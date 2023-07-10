//
//  ShadowView.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

class ShadowView: UIView {

	init(frame: CGRect, cornerRadius: CGFloat = 15) {
		super.init(frame: frame)

		// corner radius
		self.layer.cornerRadius = cornerRadius

		// shadow
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 2, height: 2)
		self.layer.shadowOpacity = 0.2
		self.layer.shadowRadius = 3.0

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
