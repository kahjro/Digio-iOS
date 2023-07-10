//
//  NSObject+class.swift
//  Digio-iOS
//
//  Created by Kazuo on 10/07/23.
//

import Foundation

extension NSObject {
	static var className: String {
		return String(describing: self)
	}
}
