//
//  ProductListRouter.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

protocol ProductListRoutingLogic {
	func routeToDetails(with detail: ProductDetail)
}

final class ProductListRouter: ProductListRoutingLogic {

	private weak var viewController: UIViewController?

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func routeToDetails(with detail: ProductDetail) {
		viewController?.present(BannerProductDetailViewController(detail: detail), animated: true)
	}
}
