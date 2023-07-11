//
//  UIImageView+Extension.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import UIKit

extension UIImageView {

	func setImage(from url: String) {
		guard let imageURL = URL(string: url) else { return }

		DispatchQueue.global().async {
			if let imageData = try? Data(contentsOf: imageURL) {
				let image = UIImage(data: imageData)
				DispatchQueue.main.async {
					self.image = image
				}
			} else {
				let image = UIImage(named: "wifi-slash")
				DispatchQueue.main.async {
					self.image = image
				}
			}

			
		}
	}
}
