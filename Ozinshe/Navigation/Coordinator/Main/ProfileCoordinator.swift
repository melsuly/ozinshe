//
//  ProfileCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

protocol ProfileCoordinatorDelegate: AnyObject {
    func userDidLogout()
}

class ProfileCoordinator: BaseCoordinator, ProfileViewControllerDelegate, LogoutModalViewControllerDelegate {

    weak var parentCoordinator: ProfileCoordinatorDelegate?
    
    func start() {
        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        profileVC.tabBarItem = UITabBarItem(title: nil, image: .TabBar.profile, selectedImage: .TabBar.profileSelected)
        router.push(profileVC, animated: false)
    }
    
    func presentLogoutModal() {
        let logoutModalVC = LogoutModalViewController()
        logoutModalVC.delegate = self
        router.presentPanModal(logoutModalVC)
    }
    
    func userDidLogout() {
        parentCoordinator?.userDidLogout()
    }
}
