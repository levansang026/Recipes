//
//  NetworkService.swift
//  Recipes
//
//  Created by Sang Le on 9/26/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import Foundation
import RxSwift

/// Used to fetch data from network
final class NetworkService: Networking {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    
    @discardableResult func fetch(resource: Resource) -> Observable<(Data?, Error?)> {
        return Observable<(Data?, Error?)>.create { (observer) -> Disposable in
            guard let request = self.makeRequest(resource: resource) else {
                let error = NSError(domain: "fetch", code: 1, userInfo: [NSLocalizedDescriptionKey: "fetch error"])
                observer.onError(error)
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    observer.onError(error!)
                    return
                }
                
                observer.onNext((data, nil))
                observer.onCompleted()
            })
            
            task.resume()
            return Disposables.create()
        }
    }
    
    @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask? {
        guard let request = makeRequest(resource: resource) else {
            completion(nil)
            return nil
        }
        
        let task = session.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
        })
        
        task.resume()
        return task
    }
    
    /// Convenient method to make request
    ///
    /// - Parameters:
    ///   - resource: Network resource
    /// - Returns: Constructed URL request
    private func makeRequest(resource: Resource) -> URLRequest? {
        let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
        guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            assertionFailure()
            return nil
        }
        
        component.queryItems = resource.parameters.map({
            return URLQueryItem(name: $0, value: $1)
        })
        
        guard let resolvedUrl = component.url else {
            assertionFailure()
            return nil
        }
        
        var request = URLRequest(url: resolvedUrl)
        request.httpMethod = resource.httpMethod
        return request
    }
}
