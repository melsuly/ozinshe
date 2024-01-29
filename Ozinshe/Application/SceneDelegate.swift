//
//  SceneDelegate.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else {
			return
		}
		let window = UIWindow(windowScene: windowScene)
		let rootVC = OnboardingViewController()
		
		window.rootViewController = UINavigationController(rootViewController: rootVC)
		window.makeKeyAndVisible()
		
		self.window = window
	}
}

