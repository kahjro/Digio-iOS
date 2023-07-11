//
//  ProductListPresenter.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import Foundation

protocol ProductListPresenterLogic {
	func presentProductList(response: ProductsModel)
	func presentLoadError()
}

final class ProductListPresenter: ProductListPresenterLogic {

	private weak var delegate: ProductListDisplayLogic?

	init(delegate: ProductListDisplayLogic) {
		self.delegate = delegate
	}

	func presentLoadError() {
		delegate?.presentError()
	}

	func presentProductList(response: ProductsModel) {
		delegate?.presentSpotlight(with: response.spotlight)
		delegate?.presentProducts(with: response.products)
		delegate?.presentCash(with: response.cash)
	}
}
