//
//  TabBarController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupTabs()
	}
}

extension TabBarController {
	private func setupViews() {
		tabBar.unselectedItemTintColor = .TabBar.item
	}
	
	private func setupTabs() {
		let homeVC = HomeViewController()
		let searchVC = SearchViewController()
		let favoritesVC = FavoritesViewController()
		let profileVC = ProfileViewController()
		
		homeVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.home, selectedImage: .TabBar.homeSelected)
		searchVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.search, selectedImage: .TabBar.searchSelected)
		favoritesVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.favorites, selectedImage: .TabBar.favoritesSelected)
		profileVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.profile, selectedImage: .TabBar.profileSelected)
		
		let viewControllers = [homeVC, searchVC, favoritesVC, profileVC].map {
			NavigationController(rootViewController: $0)
		}
		
		setViewControllers(viewControllers, animated: false)
	}
}
