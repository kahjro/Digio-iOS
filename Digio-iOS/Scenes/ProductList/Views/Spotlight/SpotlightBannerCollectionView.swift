//
//  SpotlightBannerCollectionView.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

protocol SpotlightBannerDelegate: AnyObject {
	func spotlightClicked(_ spotlight: Spotlight)
}

final class SpotlightBannerCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

	private var spotlight: [Spotlight] = []

	private var selectionDelegate: SpotlightBannerDelegate?

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

		register(SpotlightBannerCell.self, forCellWithReuseIdentifier: SpotlightBannerCell.className)
	}

	func setup(spotlight: [Spotlight], delegate: SpotlightBannerDelegate) {
		self.spotlight = spotlight
		self.selectionDelegate = delegate
		DispatchQueue.main.async {
			self.reloadData()
		}
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		spotlight.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpotlightBannerCell.className, for: indexPath) as? SpotlightBannerCell else {
			return UICollectionViewCell()
		}
		cell.setupBanner(url: spotlight[indexPath.row].bannerURL)

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectionDelegate?.spotlightClicked(spotlight[indexPath.row])
	}

}
