//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

protocol NetworkLogging: AnyObject {
    func log(request: URLRequest)
    func log(response: URLResponse)
}

class NetworkLogger: NetworkLogging {
    func log(request: URLRequest) {
        // do some logging
    }
    
    func log(response: URLResponse) {
        // do some logging
    }
}
