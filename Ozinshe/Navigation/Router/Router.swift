//
//  Router.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit
import PanModal

protocol Router: AnyObject, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    
    /// The navigation controller used for managing the navigation stack.
    var navigationController: NavigationController { get }
    
    /// The root view controller of the navigation controller.
    var rootViewController: UIViewController? { get }
    
    /// Presents a view controller modally.
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - animated: Specifies whether the presentation is animated.
    ///   - completion: An optional completion handler to call after the presentation finishes.
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Dismisses the currently presented view controller.
    /// - Parameters:
    ///   - animated: Specifies whether the dismissal is animated.
    ///   - completion: An optional completion handler to call after the dismissal finishes.
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    /// Pushes a view controller onto the navigation controller's stack.
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - animated: Specifies whether the push is animated.
    ///   - completion: An optional completion handler to call after the push finishes.
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Pops the top view controller from the navigation controller's stack.
    /// - Parameter animated: Specifies whether the pop is animated.
    func popViewController(animated: Bool)
    
    /// Sets the root view controller of the navigation controller, optionally hiding the navigation bar.
    /// - Parameters:
    ///   - viewController: The view controller to set as root.
    ///   - hideBar: Specifies whether to hide the navigation bar.
    ///   - animated: Specifies whether the change is animated.
    func setRootViewController(_ viewController: UIViewController, hideBar: Bool, animated: Bool)
}

/// Extension to provide default parameter values
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
