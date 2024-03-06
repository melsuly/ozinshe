//
//  HomeCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    func start() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.home, selectedImage: .TabBar.homeSelected)
        router.push(homeVC, animated: false)
    }
}
