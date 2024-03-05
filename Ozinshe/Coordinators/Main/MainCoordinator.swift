//
//  MainCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func didFinishFlow(with coordinator: MainCoordinator)
}

class MainCoordinator: BaseCoordinator, ProfileCoordinatorDelegate {
    var tabBarController: UITabBarController?
    var isColdLaunch: Bool = true
    
    weak var parentCoordinator: MainCoordinatorDelegate?
    
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.modalPresentationStyle = .overFullScreen
        tabBarController.modalTransitionStyle = .flipHorizontal
        
        let homeCoordinator = makeHomeCoordinator()
        add(child: homeCoordinator)
        let searchCoordinator = makeSearchCoordinator()
        add(child: searchCoordinator)
        let favoritesCoordinator = makeFavoritesCoordinator()
        add(child: favoritesCoordinator)
        let profileCoordinator = makeProfileCoordinator()
        add(child: profileCoordinator)
        
        self.tabBarController = tabBarController
        
        configure(tabBarController: tabBarController, with: [homeCoordinator, searchCoordinator, favoritesCoordinator, profileCoordinator])
        router.present(tabBarController, animated: !isColdLaunch) {
            tabBarController.dismiss(animated: true)
        }
    }
    
    private func makeHomeCoordinator() -> HomeCoordinator {
        let navigationController = UINavigationController()
        let router = DefaultRouter(navigationController: navigationController)
        let coordinator = HomeCoordinator(router: router)
        coordinator.start()
        return coordinator
    }
    
    private func makeSearchCoordinator() -> SearchCoordinator {
        let navigationController = UINavigationController()
        let router = DefaultRouter(navigationController: navigationController)
        let coordinator = SearchCoordinator(router: router)
        coordinator.start()
        return coordinator
    }
    
    private func makeFavoritesCoordinator() -> FavoritesCoordinator {
        let navigationController = UINavigationController()
        let router = DefaultRouter(navigationController: navigationController)
        let coordinator = FavoritesCoordinator(router: router)
        coordinator.start()
        return coordinator
    }
    
    private func makeProfileCoordinator() -> ProfileCoordinator {
        let navigationController = UINavigationController()
        let router = DefaultRouter(navigationController: navigationController)
        let coordinator = ProfileCoordinator(router: router)
        coordinator.parentCoordinator = self
        coordinator.start()
        return coordinator
    }
    
    func configure(tabBarController: UITabBarController, with coordinators: [Coordinator]) {
        let viewControllers = coordinators.map {
            $0.router.navigationController as! UINavigationController
        }

        tabBarController.setViewControllers(viewControllers, animated: false)
    }
    
    func userDidLogout() {
        childCoordinators.removeAll()
        
        AuthenticationService.shared.token = ""
        parentCoordinator?.didFinishFlow(with: self)
    }
}
