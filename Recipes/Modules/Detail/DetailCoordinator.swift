//
//  DetailCoordinator.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import SafariServices

final class DetailCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var recipeDetailViewController: RecipeDetailViewController?
    private var recipe: Recipe?
    init(presenter: UINavigationController, recipe: Recipe) {
        self.presenter = presenter
        self.recipe = recipe
    }
    
    func start() {
        guard let recipe = recipe else { return }
        self.recipeDetailViewController = RecipeDetailViewController(recipe: recipe, recipesService: RecipesService(networking: NetworkService()))
        
        recipeDetailViewController?.selectInstruction = { [weak self] url in
            self?.presentWebView(with: url)
        }
        
        recipeDetailViewController?.selectOriginal = { [weak self] url in
            self?.presentWebView(with: url)
        }
        presenter.pushViewController(recipeDetailViewController!, animated: true)
    }
    
    private func presentWebView(with url: URL) {
        let controller = SFSafariViewController(url: url)
        self.presenter.pushViewController(controller, animated: true)
    }
}
