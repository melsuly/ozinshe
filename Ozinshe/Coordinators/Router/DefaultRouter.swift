//
//  DefaultRouter.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

class DefaultRouter: NSObject, Router {
    var completions: [UIViewController: () -> Void] = [:]
    
    var navigationController: NavigationController {
        didSet {
            navigationController.delegate = self
        }
    }
    
    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let completion = completion {
            completions[viewController] = completion
        }
        
        viewController.presentationController?.delegate = self
        navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let topController = navigationController.presentedViewController {
            completions.removeValue(forKey: topController)
        }
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let completion = completion {
            completions[viewController] = completion
        }
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController, hideBar: Bool = false, animated: Bool = false) {
        completions.forEach { $0.value() }
        navigationController.setViewControllers([viewController], animated: animated)
        navigationController.isNavigationBarHidden = hideBar
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        checkNavigationCompletion(for: navigationController)
    }
    
    func checkNavigationCompletion(for navigationController: NavigationController) {
        guard let fromViewController = navigationController.fromViewController,
              !navigationController.viewControllers.contains(fromViewController)
        else { return }
        
        runCompletion(for: fromViewController)
    }
    
    // MARK: - UIAdaptivePresentationControllerDelegate
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        runCompletion(for: presentationController.presentedViewController)
    }

}
