//
//  ProductMapper.swift
//  Digio-iOS
//
//  Created by Kazuo on 05/07/23.
//

import Foundation

final class ProductMapper {
	static func map(_ data: Data, from response: HTTPURLResponse) throws -> ProductsModel {
		guard response.statusCode == 200, let result = try? JSONDecoder().decode(ProductsModel.self, from: data) else {
			throw NetworkError.invalidData
		}

		return result
	}
}
