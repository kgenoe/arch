//
//  ArchCacheItem.swift
//  arch
//
//  Created by Kyle Genoe on 2020-03-26.
//  Copyright © 2020 Kyle Genoe. All rights reserved.
//

import Foundation

struct ArchCacheItem: Codable {
    var data: Data?
    
    /// Caching URLResponse may be supported in the future.
//    var response: URLResponse
    
    // Note that ArchCacheItem does not save the Error? returned form the request. As Error? is not Codable, it would be difficult to do so. Any error related to why the request failed should be tested elsewhere.
}
