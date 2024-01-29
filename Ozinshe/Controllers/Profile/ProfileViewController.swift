//
//  ProfileViewController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

class ProfileViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
}

extension ProfileViewController {
	private func setupViews() {
		view.backgroundColor = .appBackground
		(navigationController as? NavigationController)?.setupShadow()
		navigationItem.title = "Профиль"
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: .Icons.logout, style: .plain, target: self, action: #selector(logout))
	}
}

extension ProfileViewController {
	@objc
	private func logout() {
		let logoutModalVC = LogoutModalViewController()
		
		presentPanModal(logoutModalVC)
	}
}
