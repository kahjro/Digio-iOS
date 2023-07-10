//
//  ProductListTests.swift
//  Digio-iOSTests
//
//  Created by Kazuo on 04/07/23.
//

import XCTest
@testable import Digio_iOS

final class ProductListTests: XCTestCase {
	
	var sut: ProductListViewController!
	var apiMock: ProductListServiceMock!
	var interactorSpy: ProductListInteractorSpy!
	
	override func setUp()
	{
		super.setUp()
		setupProductListViewController()
	}

	override func tearDown()
	{
		super.tearDown()
	}

	// MARK: - Test setup

	func setupProductListViewController()
	{
		sut = ProductListViewController()
		apiMock = ProductListServiceMock()
		interactorSpy = ProductListInteractorSpy()
	}
	
	func test_stateShouldBeSucess() {

		guard let mock = ProductJsonMock.getProduct() else {
			XCTFail()
			return
		}

		apiMock.response = .success(mock)
		sut.interactor = interactorSpy
		sut.loadView()
		sut.viewDidLoad()

		XCTAssertTrue(interactorSpy.didGetProductsList)
		
	}
}
