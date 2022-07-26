//
//  SceneDelegate.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let viewController = LogInViewController()
        viewController.configure(with: LogInViewModel())

        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
