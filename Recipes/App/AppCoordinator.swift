//
//  AppCoordinator.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let homeCoordinator: HomeCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        homeCoordinator = HomeCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
