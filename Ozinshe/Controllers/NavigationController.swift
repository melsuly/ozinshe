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
			
		let backButtonItem = UIBarButtonItem(image: .BackButton.icon, style: .plain, target: self, action: #selector(goBack))
		backButtonItem.tintColor = .BackButton.tint
		
		viewController.navigationItem.leftBarButtonItem = backButtonItem
	}
}

extension NavigationController {
	private func setupViews() {
		navigationBar.titleTextAttributes = [
			.font: UIFont.appFont(ofSize: 16, weight: .bold)
		]
	}
}

extension NavigationController {
	@objc
	private func goBack() {
		self.popViewController(animated: true)
	}
}
