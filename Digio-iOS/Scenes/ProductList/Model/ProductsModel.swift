//
//  ProductsModel.swift
//  Digio-iOS
//
//  Created by Kazuo on 05/07/23.
//

import Foundation

struct ProductsModel: Codable {
	let spotlight: [Spotlight]
	let products: [Product]
	let cash: Cash
}

struct Spotlight: Codable {
	let name: String
	let bannerURL: String
	let description: String
}

struct Product: Codable {
	let name: String
	let imageURL: String
	let description: String
}

struct Cash: Codable {
	let title: String
	let bannerURL: String
	let description: String
}
