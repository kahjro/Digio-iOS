//
//  UIView+Constraints.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

extension UIView {

	func addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], constraints: [NSLayoutConstraint]) {
		addSubview(view, affectedViews: affectedViews)

		NSLayoutConstraint.activate(constraints)
	}

	func addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], _ viewBuilder: (T) -> Void) {
		addSubview(view, affectedViews: affectedViews)

		viewBuilder(view)
	}

	func addSubview<T: UIView>(equalConstraintsFor view: T, affectedViews: [T] = []) {
		addSubview(view, affectedViews: affectedViews)

		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor),
			view.trailingAnchor.constraint(equalTo: trailingAnchor),
			view.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	func addSubview<T: UIView>(_ view: T, autoresizingMask: UIView.AutoresizingMask) {
		addSubview(view)

		view.autoresizingMask = autoresizingMask
	}

	private func addSubview<T: UIView>(_ view: T, affectedViews: [T]) {
		addSubview(view)

		[affectedViews + [view]].flatMap(Set.init).forEach { view in
			view.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}
