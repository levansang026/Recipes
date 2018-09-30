//
//  HomeCoordinator.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import RxSwift

class HomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var homeController: HomeViewController?
    private var detailCoordinator: DetailCoordinator?
    private let disposeBag = DisposeBag()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let service = RecipesService(networking: NetworkService())
        homeController = HomeViewController(recipesService: service)
        homeController?.viewModel = HomeViewModel()
        guard let homeController = homeController else { return }
        
        homeController.viewModel.selectItemSubject.subscribe(onNext: { [weak self] recipe in
            if let recipe = recipe {
                self?.didSelect(recipe: recipe)
            }
        }).disposed(by: disposeBag)
        
        presenter.pushViewController(homeController, animated: true)
    }
    
    private func didSelect(recipe: Recipe) {
        let detailCoordinator = DetailCoordinator(presenter: presenter, recipe: recipe)
        detailCoordinator.start()
        self.detailCoordinator = detailCoordinator
    }
}
