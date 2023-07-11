//
//  ProductListInteractor.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import Foundation

protocol ProductListInteractorLogic {
	func getProductsList()
}

final class ProductListInteractor: ProductListInteractorLogic {

	private var presenter: ProductListPresenterLogic
	private var service: ProductServiceLogic

	init(presenter: ProductListPresenterLogic, service: ProductServiceLogic) {
		self.presenter = presenter
		self.service = service
	}

	func getProductsList() {
		service.getProducts { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(productList):
				presenter.presentProductList(response: productList)

			case .failure:
				presenter.presentLoadError()
			}
		}
	}
}
