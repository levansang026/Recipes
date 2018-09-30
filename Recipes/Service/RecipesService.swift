//
//  RecipesService.swift
//  Recipes
//
//  Created by Sang Le on 9/24/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import Foundation
import RxSwift

final class RecipesService {
    private let baseUrl = URL(string: "https://food2fork.com/api")!
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    /// Fetch recipes with highest rating
    func fetchTopRating() -> Observable<[Recipe]> {
        let resource = Resource(url: baseUrl, path: "search", parameters: [
            "key": AppConfig.apiKey
            ])
        
        return networking.fetch(resource: resource).map { (data, error) -> [Recipe] in
            data.flatMap({ RecipeListResponse.make(data: $0)?.recipes }) ?? []
        }
    }
    
    /// Fetch single entity based on recipe id
    ///
    /// - Parameters:
    ///   - recipeId: The recipe id
    ///   - completion: Called when operation finishes
    func fetch(recipeId: String) -> Observable<Recipe?> {
        let resource = Resource(url: baseUrl, path: "get", parameters: [
            "key": AppConfig.apiKey,
            "rId": recipeId
            ])
        
        return networking.fetch(resource: resource).map { (data, error) -> Recipe? in
            data.flatMap({ RecipeResponse.make(data: $0)?.recipe })
        }
    }
    
    /// Search recipes based on query
    ///
    /// - Parameters:
    ///   - query: The search query
    /// - Returns: The network task
    @discardableResult func search(query: String) -> Observable<[Recipe]> {
        let resource = Resource(url: baseUrl, path: "search", parameters: [
            "key": AppConfig.apiKey,
            "q": query
            ])
        
        return networking.fetch(resource: resource).debounce(2, scheduler: MainScheduler.asyncInstance).map { (data, error) -> [Recipe] in
            data.flatMap { RecipeListResponse.make(data: $0)?.recipes } ?? []
        }
        
    }
}

private class RecipeListResponse: Decodable {
    let count: Int
    let recipes: [Recipe]
    
    static func make(data: Data) -> RecipeListResponse? {
        return try? JSONDecoder().decode(RecipeListResponse.self, from: data)
    }
}

private class RecipeResponse: Decodable {
    let recipe: Recipe
    
    static func make(data: Data) -> RecipeResponse? {
        return try? JSONDecoder().decode(RecipeResponse.self, from: data)
    }
}
