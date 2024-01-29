//
//  NavigationController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

class NavigationController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: animated)
		
		if viewControllers.count > 1 {
			let backButtonItem = UIBarButtonItem(image: .BackButton.icon, style: .plain, target: self, action: #selector(goBack))
			backButtonItem.tintColor = .BackButton.tint
			
			viewController.navigationItem.leftBarButtonItem = backButtonItem
		}
	}
}

extension NavigationController {
	private func setupViews() {
		navigationBar.titleTextAttributes = [
			.font: UIFont.appFont(ofSize: 16, weight: .bold)
		]
	}
	
	func setupShadow() {
		navigationBar.layer.shadowColor = UIColor.black.cgColor
		navigationBar.layer.shadowOpacity = 0.1
		navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1)
		navigationBar.layer.shadowRadius = 0.1
		navigationBar.layer.shadowPath = UIBezierPath(
			rect: CGRect(x: 0, y: navigationBar.bounds.maxY, width: navigationBar.bounds.width, height: 1)
		).cgPath
	}
}

extension NavigationController {
	@objc
	private func goBack() {
		self.popViewController(animated: true)
	}
}
