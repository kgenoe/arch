//
//  ArchCachingManager.swift
//  arch
//
//  Created by Kyle Genoe on 2020-03-26.
//  Copyright © 2020 Kyle Genoe. All rights reserved.
//

import Foundation

class ArchCachingManager: NSObject {
    
    
    /// The local path to the cache. Located within the user document directory.
    var cachePath: URL {
        let fm = FileManager.default
        var path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        path.appendPathComponent("arch-cache")
        return path
    }
    
    
    /**
     Checks the cache for the existance of a given `URLRequest`.
     
     - Parameter request: The `URLRequest` for which a response is being asked for
     
     - Returns: The corresponding `ArchCacheItem` for the provided `URLRequest`. If no item exists in the cache for the provided request, nil is returned.
     
     */
    func checkCacheFor(request: URLRequest) -> ArchCacheItem? {
        
        let cacheItemTitle =  hashURLRequest(request)
        
        // Check if the response exists in the cache
        let cacheItemURL = cachePath.appendingPathComponent(cacheItemTitle)
        guard FileManager.default.fileExists(atPath: cacheItemURL.path) else {
            print("Existing response file does not exist")
            return nil
        }
        
        // Read response data from cache file
        guard let cacheItemData = FileManager.default.contents(atPath: cacheItemURL.path) else {
            print("Cannot read file at path")
            return nil
        }
        
        // Convert read data into an ArchCacheItem
        do {
            return try JSONDecoder().decode(ArchCacheItem.self, from: cacheItemData)
        } catch {
            print("An error occured creating ArchCacheItem from data")
            return nil
        }
    }
    
    
    
    /**
     Saves a `URLRequest` and it's corresponding response `Data?` to the cache
     
     - Parameters:
        - request: The `URLRequest` object that sent the API request
        - data: The `Data?` that was returned from the API request
     */
    func saveToCache(request: URLRequest, data: Data?) {
        
        let cacheItemTitle = hashURLRequest(request)
        let cacheItemURL = cachePath.appendingPathComponent(cacheItemTitle)
        let item = ArchCacheItem(data: data)
        
        let fm = FileManager.default
        
        do {
            
            // create directory if needed
            if !fm.fileExists(atPath: cachePath.path) {
                try fm.createDirectory(atPath: cachePath.path, withIntermediateDirectories: true, attributes: nil)
            }
            
            
            // save cache item
            let cacheItemData = try JSONEncoder().encode(item)
            FileManager.default.createFile(atPath: cacheItemURL.path, contents: cacheItemData, attributes: nil)
            
            print("Update Cache: \(cacheItemURL.path)")
        } catch {
            print("Error saving ArchCacheItem: \(error)")
        }
    }
    
    
    /**
     A hash value for a `URLRequest`. Used to hash a `URLRequest` based on url, http method, http headers and http body.
     */
    private func hashURLRequest(_ urlRequest: URLRequest) -> String {
        
        let url = urlRequest.url
        let urlString = url?.absoluteString ?? ""
        
        let httpMethod = urlRequest.httpMethod ?? ""
        
        let httpBody = urlRequest.httpBody ?? Data()
        let httpBodyString = String(data: httpBody, encoding: .utf8)!
        
        let httpHeaders = urlRequest.allHTTPHeaderFields ?? [:]
        let keys = httpHeaders.keys.sorted()
        var httpHeadersString = ""
        for key in keys {
            httpHeadersString += key + (httpHeaders[key] ?? "")
        }
        
        var hash = urlString.hash ^ httpMethod.hash
        hash = hash ^ httpBodyString.hash
        hash = hash ^ httpHeadersString.hash
        
        return "\(hash)"
    }
    
}
