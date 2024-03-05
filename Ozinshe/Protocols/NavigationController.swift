//
//  NavigationController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import UIKit

protocol NavigationController {
    var viewControllers: [UIViewController] { get }
    var delegate: UINavigationControllerDelegate? { get set }
    var isNavigationBarHidden: Bool { get set }
    var transitionCoordinator: UIViewControllerTransitionCoordinator? { get }
    var fromViewController: UIViewController? { get }
    var presentedViewController: UIViewController? { get }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
}

extension UINavigationController: NavigationController {
    var fromViewController: UIViewController? {
        return transitionCoordinator?.viewController(forKey: .from)
    }
}

