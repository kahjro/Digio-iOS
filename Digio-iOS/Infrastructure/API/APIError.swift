//
//  APIError.swift
//  Digio-iOS
//
//  Created by Kazuo on 12/07/23.
//

import Foundation

public enum APIError: Error, Equatable {
	public enum HTTPStatusCode: Int, Equatable {
		case badRequest = 400
		case unauthorized = 401
		case forbidden = 403
		case notFound = 404
		case serverError = 500
	}
	
	case invalidData
	
	case uncategorized(statusCode: Int?, errorDescription: String)
	case httpError(code: Int, data: Data?)
	
}

extension APIError: LocalizedError {
	public var errorDescription: String? {
		return self.description
	}
}

extension APIError: CustomStringConvertible {
	public var description: String {
		switch self {
		case .uncategorized(_, let errorDescription):
			return "\(errorDescription)"

		case .httpError(let code, _):
			guard let httpCode = HTTPStatusCode(rawValue: code) else { return "" }
			switch httpCode {
			case .badRequest:
				return APIErrorDescription.badRequest.text
			case .forbidden:
				return APIErrorDescription.forbidden.text
			case .notFound:
				return APIErrorDescription.notFound.text
			case .serverError:
				return APIErrorDescription.serverError.text
			case .unauthorized:
				return APIErrorDescription.unauthorized.text
			}
		case .invalidData:
			return APIErrorDescription.unauthorized.text
		}
	}
}

enum APIErrorDescription: String {
	case serialization
	case badRequest
	case forbidden
	case notFound
	case serverError
	case unauthorized
	case invalidData

	var text: String {
		return NSLocalizedString(self.rawValue, comment: "")
	}
}
