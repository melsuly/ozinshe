//
//  GuestCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import Foundation

protocol GuestFlowCoordinatorDelegate: AnyObject {
    func didFinishFlow(from coordinator: GuestFlowCoordinator)
}

class GuestFlowCoordinator: BaseCoordinator, AuthenticationDelegate {
    
    weak var parentCoordinator: GuestFlowCoordinatorDelegate?
    
    func start() {
        showOnboarding()
    }
    
    func showOnboarding() {
        let onboardingViewModel = DependencyHelper.shared.resolve(OnboardingViewModel.self)!
        let onboardingVC = OnboardingViewController(viewModel: onboardingViewModel)
        onboardingVC.coordinator = self
        router.setRootViewController(onboardingVC, hideBar: true, animated: false)
    }
    
    // MARK: - AuthenticationDelegate
    
    func showLogin() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        router.push(loginVC, animated: true)
    }
    
    func showRegistration() {
        let registrationVC = RegistrationViewController()
        registrationVC.coordinator = self
        router.push(registrationVC, animated: true)
    }
    
    func didSuccessfullyAuthenticated() {
        parentCoordinator?.didFinishFlow(from: self)
    }
}
