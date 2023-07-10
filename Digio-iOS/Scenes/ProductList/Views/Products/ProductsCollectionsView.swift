//
//  ProductsCollectionsView.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

protocol ProductsBannerDelegate: AnyObject {
	func productClicked(_ product: Product)
}

final class ProductsBannerCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
	
	private var products: [Product] = []
	private var selectionDelegate: ProductsBannerDelegate?
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		dataSource = self
		delegate = self
		
		register(ProductsBannerCell.self, forCellWithReuseIdentifier: ProductsBannerCell.className)
	}
	
	func setup(products: [Product], delegate: ProductsBannerDelegate) {
		self.products = products
		self.selectionDelegate = delegate
		DispatchQueue.main.async {
			self.reloadData()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		products.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsBannerCell.className, for: indexPath) as? ProductsBannerCell else {
			return UICollectionViewCell()
		}
		cell.setupBanner(url: products[indexPath.row].imageURL)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectionDelegate?.productClicked(products[indexPath.row])
	}
	
}
