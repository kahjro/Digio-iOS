//
//  URLSessionHTTPClient.swift
//  Digio-iOS
//
//  Created by Kazuo on 05/07/23.
//

import Foundation

protocol HTTPClient {
	typealias Result = Swift.Result<(data: Data, response: HTTPURLResponse), Error>

	func getRequest(from url: URL, completion: @escaping (Result) -> Void)
}

final class URLSessionHTTPClient: HTTPClient {
	private let session: URLSession
	private struct UnexpectedValuesRepresentation: Error {}

	init(session: URLSession = .shared) {
		self.session = session
	}

	func getRequest(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
		let task = session.dataTask(with: url) { data, response, error in
			completion(Result {
				if let error = error {
					throw error
				} else if let data = data, let response = response as? HTTPURLResponse {
					return (data, response)
				} else {
					throw UnexpectedValuesRepresentation()
				}
			})
		}
		task.resume()
	}
}

enum NetworkError: Error {
	case connectivity
	case invalidData
}
