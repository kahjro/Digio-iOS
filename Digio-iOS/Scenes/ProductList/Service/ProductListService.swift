//
//  ProductListService.swift
//  Digio-iOS
//
//  Created by Kazuo on 05/07/23.
//

import Foundation

protocol ProductServiceLogic {
	typealias Result = Swift.Result<ProductsModel, Error>

	func getProducts(completion: @escaping (Result) -> Void)
}

final class ProductListService: ProductServiceLogic {
	typealias Result = ProductServiceLogic.Result

	private let client: HTTPClient = URLSessionHTTPClient()

	func getProducts(completion: @escaping (Result) -> Void) {
		let url = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products")!
		client.getRequest(from: url) { result in
			switch result {
			case .success(let (data, response)):
				completion(ProductListService.map(data, from: response))
			case .failure:
				completion(.failure(NetworkError.connectivity))
			}
		}
	}

	private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
		do {
			let products = try ProductMapper.map(data, from: response)
			return .success(products)
		} catch {
			return .failure(error)
		}
	}
}
