//
//  RecipeDetailViewModel.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import RxSwift

class RecipeDetailViewModel {
    
    private let disposeBag = DisposeBag()
    private var recipeService: RecipesService!
    private var recipe: Recipe? {
        get {
            return recipeSubject.
        }
        
        set {
            
        }
    }
    
    init(recipeService: RecipesService) {
        self.recipeService = recipeService
    }
    
    func fetchRecipeDetail(with id: String) {
        recipeService.fetch(recipeId: id).subscribe(onNext: { [weak self] recipe in
            self?.recipe = recipe
            }, onError: { error in
                print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
