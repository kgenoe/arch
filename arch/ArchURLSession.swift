//
//  ArchURLSession.swift
//  arch
//
//  Created by Kyle Genoe on 2020-03-26.
//  Copyright © 2020 Kyle Genoe. All rights reserved.
//

import Foundation

public class ArchURLSession: URLSession {
    
    public override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return ArchDataTask(urlRequest: request, completionHandler: completionHandler)
    }
    
    public override func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: with)
        return ArchDataTask(urlRequest: request, completionHandler: completionHandler)
    }
}
