//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import Foundation
import RxSwift

final class RecipeListViewModel {
    var recipesVariable = Variable<[Recipe]>([])
    private let recipeService: RecipesService
    private let disposeBag = DisposeBag()

    var recipes: [Recipe] {
        get {
            return recipesVariable.value
        }
        
        set {
            recipesVariable.value = newValue
        }
    }
    
    init() {
        recipeService = RecipesService(networking: NetworkService())
    }
    
    func fetchTopRating() {
        recipeService.fetchTopRating().subscribe(onNext: { [weak self] recipes in
            self?.recipes = recipes
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func search(with query: String) {
        recipeService.search(query: query).subscribe(onNext: { [weak self] recipes in
            self?.recipes = recipes
            }, onError: { error in
                print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
