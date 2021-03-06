//
//  SearchComponent.swift
//  Recipes
//
//  Created by Sang Le on 9/24/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import RxSwift

final class SearchComponent: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
    var recipesService: RecipesService
    var searchController: UISearchController
    let recipeListViewController = RecipeListViewController()
    var task: URLSessionTask?
    private lazy var loadingIndicator: UIActivityIndicatorView = self.makeLoadingIndicator()
    let disposeBag = DisposeBag()
    
    required init(recipesService: RecipesService) {
        self.recipesService = recipesService
        recipeListViewController.viewModel = RecipeListViewModel()
        self.searchController = UISearchController(searchResultsController: recipeListViewController)
        super.init()
        setupViews()
    }
    
    private func setupViews() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search recipe"
        
        recipeListViewController.view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
    }
        
    
    /// Add search bar to view controller
    func add(to viewController: UIViewController) {
        if #available(iOS 11, *) {
            viewController.navigationItem.searchController = searchController
            viewController.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            viewController.navigationItem.titleView = searchController.searchBar
        }
        
        viewController.definesPresentationContext = true
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        // No op
    }
    
    // MARK: - UISearchBarDelegate
    //debounce
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.performSearch()
    }
    
    // MARK: - Logic
    
    private func performSearch() {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        
        search(query: text)
    }
    
    private func search(query: String) {
        task?.cancel()
        loadingIndicator.startAnimating()
        recipesService.search(query: query).subscribe(onNext: { [weak self] recipes in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.recipeListViewController.handle(recipes: recipes)
            }
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Make
    
    private func makeLoadingIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.color = .darkGray
        view.hidesWhenStopped = true
        return view
    }
}
