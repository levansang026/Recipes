//
//  Networking.swift
//  Recipes
//
//  Created by Sang Le on 9/24/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import Foundation
import RxSwift

protocol Networking {
    
    /// Fetch data from url and parameters query
    ///
    /// - Parameters:
    ///   - url: The url
    ///   - parameters: Parameters as query items
    ///   - completion: Called when operation finishes
    /// - Returns: The data task
    @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask?
    @discardableResult func fetch(resource: Resource) -> Observable<(Data?, Error?)>
}
