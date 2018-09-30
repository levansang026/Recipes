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
    var viewModel: HomeViewModel!
    private var refreshControl = UIRefreshControl()
    private let searchComponent: SearchComponent
    private let recipeListViewController = RecipeListViewController()
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    required init(recipesService: RecipesService) {
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
        setupBindings()
        loadData()
    }
    
    // MARK: - Setup
    private func setup() {
        recipeListViewController.viewModel = RecipeListViewModel()
        add(childViewController: recipeListViewController)
        recipeListViewController.collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        searchComponent.add(to: self)
    }
    
    private func setupBindings() {
        Observable.merge(recipeListViewController.adapter.selectItemSubject, searchComponent.recipeListViewController.adapter.selectItemSubject).subscribe({ [weak self] event in
            self?.viewModel.selectItemSubject.onNext(event.element)
        }).disposed(by: disposeBag)
        
        recipeListViewController
            .viewModel.recipesVariable
            .asObservable().subscribe(onNext: { [weak self] recipes in
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Action
    @objc private func refresh() {
        loadData()
    }
    
    // MARK: - Data
    private func loadData() {
        refreshControl.beginRefreshing()
        recipeListViewController.viewModel.fetchTopRating()
    }
}
