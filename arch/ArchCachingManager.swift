//
//  ArchCachingManager.swift
//  arch
//
//  Created by Kyle Genoe on 2020-03-26.
//  Copyright © 2020 Kyle Genoe. All rights reserved.
//

import Foundation

class ArchCachingManager: NSObject {
    
    
    ///
    private(set) var cachePath = URL(string: "/arch-cache")!
    
    
    /// Looks for a cached response for a given URLRequest. If the response exists in the cache, it is returned. Otherwise, nil is returned.
    func checkCacheFor(request: URLRequest) -> ArchCacheItem? {
        
        let cacheItemTitle = hashURLRequest(request)
        
        // Check if the response exists in the cache
        let resourceURL = cachePath.appendingPathComponent(cacheItemTitle)
        guard FileManager.default.fileExists(atPath: "\(resourceURL)") else {
            print("Existing response file does not exist")
            return nil
        }
        
        // Read response data from cache file
        guard let resourceData = FileManager.default.contents(atPath: "\(resourceURL)") else {
            print("Cannot read file at path")
            return nil
        }
        
        // Convert read data into an ArchCacheItem
        do {
            return try JSONDecoder().decode(ArchCacheItem.self, from: resourceData)
        } catch {
            print("An error occured creating ArchCacheItem from data")
            return nil
        }
    }
    
    
    ///
    func saveItemToCache(request: URLRequest, data: Data?) {
        
        let cacheItemTitle = hashURLRequest(request)
        let item = ArchCacheItem(data: data)
        
        do {
            let resourceData = try JSONEncoder().encode(item)
            
            FileManager.default.createFile(atPath: "\(cacheItemTitle)", contents: resourceData, attributes: nil)
        } catch {
            print("Error saving ArchCacheItem: \(error)")
        }
    }
    
    
    ///
    private func hashURLRequest(_ urlRequest: URLRequest) -> String {
        return "\(urlRequest.hashValue)"
    }
    
}
