//
//  UIStackView+Constraints.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit.UIStackView

extension UIStackView {
	func addArrangedSubview(_ view: UIView, constraints: [NSLayoutConstraint]) {
		addArrangedSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(constraints)
	}
}
