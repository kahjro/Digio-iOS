//
//  ProductJsonMock.swift
//  Digio-iOSTests
//
//  Created by Kazuo on 10/07/23.
//

import Foundation
@testable import Digio_iOS

class ProductJsonMock {

	static func getJsonMock() -> Data {
		let testBundle = Bundle(for: ProductJsonMock.self)
		guard let filePath = testBundle.path(forResource: "ProductJsonMock", ofType: "txt")
			else { fatalError() }
		let jsonData = try! Data(contentsOf: URL(fileURLWithPath: filePath))
		return jsonData
	}

	static func getProduct() -> ProductsModel? {
		guard let product = try? JSONDecoder().decode(
			ProductsModel.self,
			from: ProductJsonMock.getJsonMock()) else {
			return nil
		}
		return product

	}
}
