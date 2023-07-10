//
//  UIStackView+ArrangedSubview.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

extension UIStackView {
	func addArrangedSubview(_ view: UIView?) {
		if let subview = view {
			addArrangedSubview(subview)
		}
	}

	func addArrangedSubviews(subviews: [UIView]) {
		subviews.forEach(addArrangedSubview)
	}

	func removeArrangedSubviews(subviews: [UIView]) {
		subviews.forEach(removeArrangedSubview)
	}

	func insertArrangedSubviews(_ view: UIView?, at index: Int) {
		if let subview = view {
			insertArrangedSubview(subview, at: index)
		}
	}

	func insertArrangedSubviews(_ view: UIView, at index: Int, constraints: [NSLayoutConstraint]) {
		insertArrangedSubview(view, at: index)

		if !constraints.isEmpty {
			view.translatesAutoresizingMaskIntoConstraints = false

			NSLayoutConstraint.activate(constraints)
		}
	}

	func removeAllArrangedSubviews() {
		let removedSubviews = arrangedSubviews.reduce([]) { [weak self] (allSubviews, subview) -> [UIView] in
			self?.removeArrangedSubview(subview)

			return allSubviews + [subview]
		}

		NSLayoutConstraint.deactivate(removedSubviews.flatMap({ subview in subview.constraints }))

		removedSubviews.forEach({ subview in subview.removeFromSuperview() })
	}
}

