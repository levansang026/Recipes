//
//  Resource.swift
//  Recipes
//
//  Created by Sang Le on 9/24/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import Foundation

struct Resource {
    let url: URL
    let path: String?
    let httpMethod: String
    let parameters: [String: String]
    
    init(url: URL, path: String? = nil, httpMethod: String = "GET", parameters: [String: String] = [:]) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
