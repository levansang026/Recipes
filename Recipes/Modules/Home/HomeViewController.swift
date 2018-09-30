//
//  HomeViewController.swift
//  Recipes
//
//  Created by Sang Le on 9/24/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    /// When a recipe get select
    var select: ((Recipe) -> Void)?
    
    private var refreshControl = UIRefreshControl()
    private let recipesService: RecipesService
    private let searchComponent: SearchComponent
    private let recipeListViewController = RecipeListViewController()
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    required init(recipesService: RecipesService) {
        self.recipesService = recipesService
        self.searchComponent = SearchComponent(recipesService: recipesService)
        super.init(nibName: nil, bundle: nil)
        self.title = "Recipes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupSearch()
        loadData()
    }
    
    // MARK: - Setup
    
    private func setup() {
        recipeListViewController.adapter.select = select
        add(childViewController: recipeListViewController)
        recipeListViewController.collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func setupSearch() {
        searchComponent.add(to: self)
        searchComponent.recipeListViewController.adapter.select = select
    }
    
    // MARK: - Action
    
    @objc private func refresh() {
        loadData()
    }
    
    // MARK: - Data
    
    private func loadData() {
        refreshControl.beginRefreshing()
        recipesService.fetchTopRating().subscribe(onNext: { [weak self] recipes in
            DispatchQueue.main.async {
                self?.recipeListViewController.handle(recipes: recipes)
                self?.refreshControl.endRefreshing()
            }
            }, onError: { error in
                print(error.localizedDescription)
        }).disposed(by: disposeBag)
//        recipesService.fetchTopRating(completion: { [weak self] recipes in
//            self?.recipeListViewController.handle(recipes: recipes)
//            self?.refreshControl.endRefreshing()
//        })
    }
}
