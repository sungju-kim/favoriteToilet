//
//  MainTabBarController.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/26.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
}

// MARK: - Configure

extension MainTabBarController {
    func configure() {
        tabBar.tintColor = .Custom.text

        let mapViewController = UINavigationController(rootViewController: MapViewController())
        mapViewController.tabBarItem.title = "지도"
        mapViewController.tabBarItem.image = UIImage(systemName: "map")

        viewControllers = [
            mapViewController
        ]
    }
}
