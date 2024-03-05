//
//  FavoritesCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

class FavoritesCoordinator: BaseCoordinator {
    func start() {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.favorites, selectedImage: .TabBar.favoritesSelected)
        router.push(favoritesVC, animated: false)
    }
}
