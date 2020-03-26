//
//  ArchDataTask.swift
//  arch
//
//  Created by Kyle Genoe on 2020-03-26.
//  Copyright © 2020 Kyle Genoe. All rights reserved.
//

import Foundation

public class ArchDataTask: URLSessionDataTask {
    
    public var urlRequest: URLRequest
    
    public var completionHandler: ((Data?, URLResponse?, Error?) -> Void)
    
    public init(urlRequest: URLRequest, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        self.urlRequest = urlRequest
        self.completionHandler = completionHandler
    }
    
    public override func resume() {
        
        let cachingManager = ArchCachingManager()
        
        // if item exists in cache, return the cached item
        if let item = cachingManager.checkCacheFor(request: urlRequest) {
            completionHandler(item.data, nil, nil)
        }
        
        // Otherwise, request actual data, cache response, return response
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            cachingManager.saveItemToCache(request: self.urlRequest, data: data)
            self.completionHandler(data, nil, nil)
            
        }.resume()
        
        
        // TODO: Add request timeout feature, and fallback on a user provided fallback response.
    }
}
