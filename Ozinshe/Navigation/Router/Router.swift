//
//  Router.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit
import PanModal

protocol Router: AnyObject, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    var navigationController: NavigationController { get }
    var rootViewController: UIViewController? { get }
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func popViewController(animated: Bool)
    func setRootViewController(_ viewController: UIViewController, hideBar: Bool, animated: Bool)
}

/// Adds default parameters
extension Router {
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(viewController, animated: animated, completion: completion)
    }
    
    func presentPanModal(_ viewController: PanModalPresentable.LayoutType) {
        navigationController.viewControllers.first?.presentPanModal(viewController)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        push(viewController, animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool = true) {
        popViewController(animated: animated)
    }
    
    func setRootViewController(_ viewController: UIViewController, hideBar: Bool = false, animated: Bool = false) {
        setRootViewController(viewController, hideBar: hideBar, animated: animated)
    }
}
