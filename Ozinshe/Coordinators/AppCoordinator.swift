//
//  AppCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

class AppCoordinator: BaseCoordinator, GuestFlowCoordinatorDelegate, MainCoordinatorDelegate {
    
    var window: UIWindow?
    var isColdLaunch: Bool = true
    
    init(window: UIWindow? = nil) {
        self.window = window
        
        let navigationController = UINavigationController()
        let router = DefaultRouter(navigationController: navigationController)
        super.init(router: router)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let isAuthenticated = AuthenticationService.shared.isAuthenticated
        let handler: () -> Void = isAuthenticated ? startApp : startGuestFlow
        
        handler()
        isColdLaunch = false
    }
    
    func startGuestFlow() {
        let guestFlowCoordinator = GuestFlowCoordinator(router: router)
        guestFlowCoordinator.parentCoordinator = self
        add(child: guestFlowCoordinator)
        guestFlowCoordinator.start()
    }
    
    func startApp() {
        let mainCoordinator = MainCoordinator(router: router)
        mainCoordinator.parentCoordinator = self
        mainCoordinator.isColdLaunch = isColdLaunch
        add(child: mainCoordinator)
        mainCoordinator.start()
    }
    
    // MARK: - GuestFlowCoordinatorDelegate
    
    func didFinishFlow(from coordinator: GuestFlowCoordinator) {
        router.dismiss(animated: false)
        remove(child: coordinator)
        startApp()
    }
    
    func didFinishFlow(with coordinator: MainCoordinator) {
        router.dismiss(animated: false)
        remove(child: coordinator)
        startGuestFlow()
    }
}
