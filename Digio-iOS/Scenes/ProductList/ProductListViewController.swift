//
//  ViewController.swift
//  Digio-iOS
//
//  Created by Kazuo on 04/07/23.
//

import UIKit

protocol ProductListDisplayLogic: AnyObject {
	func presentSpotlight(with spotlight: [Spotlight])
	func presentProducts(with products: [Product])
	func presentCash(with cash: Cash)
	func presentError(with description: String?)
}

class ProductListViewController: UIViewController {
	
	private lazy var titleLabel: UILabel = {
		var label = UILabel()
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		label.text = "Olá Arthur"
		label.textColor = #colorLiteral(red: 0.1188358739, green: 0.1861418486, blue: 0.2863286436, alpha: 1)
		return label
	}()
	
	private lazy var titleIcon: UIImageView = {
		var icon = UIImageView()
		var image = UIImage(named: "digio-icon")
		icon.image = image
		return icon
	}()
	
	private lazy var spotlightCollectionView: SpotlightBannerCollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 0)
		layout.itemSize = CGSize(width: view.frame.size.width - 12, height: 210)
		layout.scrollDirection = .horizontal
		var collectionView = SpotlightBannerCollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .white
		collectionView.isScrollEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.showsVerticalScrollIndicator = false
		return collectionView
	}()
	
	private lazy var cashBannerView: CashView = {
		var cashView = CashView()
		return cashView
	}()
	
	private lazy var productsLabel: UILabel = {
		var label = UILabel()
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		label.textColor = #colorLiteral(red: 0.1188358739, green: 0.1861418486, blue: 0.2863286436, alpha: 1)
		label.text = "Produtos"
		return label
	}()
	
	private lazy var productsCollectionView: ProductsBannerCollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
		layout.itemSize = CGSize(width: 130, height: 130)
		layout.scrollDirection = .horizontal
		var collectionView = ProductsBannerCollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .white
		collectionView.isScrollEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.showsVerticalScrollIndicator = false
		return collectionView
	}()
	
	lazy var presenter: ProductListPresenterLogic = {
		ProductListPresenter(delegate: self)
	}()
	
	lazy var service: ProductServiceLogic = {
		ProductListService()
	}()
	
	lazy var interactor: ProductListInteractorLogic = {
		ProductListInteractor(presenter: presenter, service: service)
	}()
	
	lazy var router: ProductListRouter = {
		ProductListRouter(viewController: self)
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		interactor.getProductsList()
		setupLayout()
	}
	
	override func loadView() {
		super.loadView()
		setupView()
	}
	
	private func setupView() {
		view.backgroundColor = .white
	}
	
	private func setupLayout() {
		view.addSubview(titleIcon, constraints: [
			titleIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			titleIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			titleIcon.widthAnchor.constraint(equalTo: titleIcon.heightAnchor),
			titleIcon.heightAnchor.constraint(equalToConstant: 36)
		])
		
		view.addSubview(titleLabel, constraints: [
			titleLabel.leadingAnchor.constraint(equalTo: titleIcon.trailingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: titleIcon.centerYAnchor)
		])
		
		view.addSubview(spotlightCollectionView, constraints: [
			spotlightCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			spotlightCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			spotlightCollectionView.topAnchor.constraint(equalTo: titleIcon.bottomAnchor, constant: 8),
			spotlightCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48)
		])
		
		view.addSubview(cashBannerView, constraints: [
			cashBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			cashBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			cashBannerView.topAnchor.constraint(equalTo: spotlightCollectionView.bottomAnchor, constant: 8),
			cashBannerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48)
		])
		
		view.addSubview(productsLabel, constraints: [
			productsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			productsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			productsLabel.topAnchor.constraint(equalTo: cashBannerView.bottomAnchor, constant: 8)
		])
		
		view.addSubview(productsCollectionView, constraints: [
			productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
			productsCollectionView.topAnchor.constraint(equalTo: productsLabel.bottomAnchor, constant: 8),
			productsCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35)
		])
	}
}

extension ProductListViewController: ProductListDisplayLogic {
	func presentSpotlight(with spotlight: [Spotlight]) {
		spotlightCollectionView.setup(spotlight: spotlight, delegate: self)
	}
	
	func presentProducts(with products: [Product]) {
		productsCollectionView.setup(products: products, delegate: self)
	}
	
	func presentCash(with cash: Cash) {
		cashBannerView.setup(cash: cash, delegate: self)
	}
	
	func presentError(with description: String?) {
		let errorAlert = UIAlertController(title: "Erro", message: description, preferredStyle: UIAlertController.Style.alert)
		
		errorAlert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { [weak self] (action: UIAlertAction!) in
			self?.interactor.getProductsList()
		}))
		DispatchQueue.main.async {
			self.present(errorAlert, animated: true, completion: nil)
		}
	}
}

extension ProductListViewController: CashBannerDelegate {
	func cashClicked(_ detail: Cash) {
		let productDetail = ProductDetail(title: detail.title,
										  imageURL: detail.bannerURL,
										  description: detail.description,
										  isBanner: true)
		router.routeToDetails(with: productDetail)
	}
}

extension ProductListViewController: SpotlightBannerDelegate {
	func spotlightClicked(_ spotlight: Spotlight) {
		let productDetail = ProductDetail(title: spotlight.name,
										  imageURL: spotlight.bannerURL,
										  description: spotlight.description,
										  isBanner: true)
		router.routeToDetails(with: productDetail)
	}
}

extension ProductListViewController: ProductsBannerDelegate {
	func productClicked(_ product: Product) {
		let productDetail = ProductDetail(title: product.name,
										  imageURL: product.imageURL,
										  description: product.description,
										  isBanner: false)
		router.routeToDetails(with: productDetail)
	}
}
