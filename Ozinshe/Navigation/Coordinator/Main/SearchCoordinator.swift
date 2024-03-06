//
//  SearchCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

class SearchCoordinator: BaseCoordinator {
    func start() {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.search, selectedImage: .TabBar.searchSelected)
        router.push(searchVC, animated: false)
    }
}
