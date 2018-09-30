//
//  HomeCoordinator.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var homeController: HomeViewController?
    private var detailCoordinator: DetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let service = RecipesService(networking: NetworkService())
        homeController = HomeViewController(recipesService: service)
        guard let homeController = homeController else { return }
        
        homeController.select = { [weak self] recipe in
            self?.didSelect(recipe: recipe)
        }
        
        presenter.pushViewController(homeController, animated: true)
    }
    
    private func didSelect(recipe: Recipe) {
        let detailCoordinator = DetailCoordinator(presenter: presenter, recipe: recipe)
        detailCoordinator.start()
        self.detailCoordinator = detailCoordinator
    }
}
