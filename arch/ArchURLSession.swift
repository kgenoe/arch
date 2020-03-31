//
//  ArchURLSession.swift
//  arch
//
//  Created by Kyle Genoe on 2020-03-26.
//  Copyright © 2020 Kyle Genoe. All rights reserved.
//

import Foundation

public class ArchURLSession: URLSession {
    
    /// The class using Arch for testing. It has two uses: 1) Existing cache files will be searched for in `testingClass`' bundle. 2) New cache files will be outputted in a folder with the same name as `testingClass`
    public var testingClass: AnyClass
    
    /**
    Creates an `ArchURLSession`, a URLSession subclass. ArchURLSession will behave as a normal URLSession if no cache exists, but saving any recieved responses to the iOS user documents directory. If a cache file exists in `testClass`' bundle, `ArchURLSession` will return that cached response.
    
    - Parameter testingClass: The class using Arch for testing. It has two uses:
       1) Existing cache files will be searched for in `testingClass`' bundle
       2) New cache files will be outputted in a folder with the same name as `testingClass`
    */
    public init(testingClass: AnyClass) {
        self.testingClass = testingClass
    }
    
    
    public override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return ArchDataTask(testingClass: testingClass, urlRequest: request, completionHandler: completionHandler)
    }
    
    
    public override func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: with)
        return ArchDataTask(testingClass: testingClass, urlRequest: request, completionHandler: completionHandler)
    }
}
