//
//  ProductListServiceMock.swift
//  Digio-iOSTests
//
//  Created by Kazuo on 10/07/23.
//

@testable import Digio_iOS

final class ProductListServiceMock: ProductServiceLogic {
	var response: ProductServiceLogic.Result!
	func getProducts(completion: @escaping (ProductServiceLogic.Result) -> Void) {
		completion(response)
	}
	
}

final class ProductListInteractorSpy: ProductListInteractorLogic {
	var didGetProductsList = false
	
	func getProductsList() {
		didGetProductsList = true
	}
}

final class ProductListPresenterSpy: ProductListPresenterLogic {
	
	var presentedProductList = false
	var presentedLoadError = false
	
	func presentProductList(response: Digio_iOS.ProductsModel) {
		presentedProductList = true
	}
	
	func presentLoadError() {
		presentedLoadError = true
	}
}

final class ProductListDisplaySpy: ProductListDisplayLogic {
	
	var presentedSpotlight = false
	var presentedProducts = false
	var presentedCash = false
	var presentedError = false

	func presentSpotlight(with spotlight: [Digio_iOS.Spotlight]) {
		presentedSpotlight = true
	}
	
	func presentProducts(with products: [Digio_iOS.Product]) {
		presentedProducts = true
	}
	
	func presentCash(with cash: Digio_iOS.Cash) {
		presentedCash = true
	}
	
	func presentError() {
		presentedError = true
	}
	
}
