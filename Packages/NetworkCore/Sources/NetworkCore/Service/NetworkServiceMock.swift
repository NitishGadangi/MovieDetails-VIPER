//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

class NetworkServiceMock<EndPoint: EndPointType>: NetworkServiceble {
    func request(_ route: EndPoint, completion: @escaping NetworkServiceCompletion) {
        do {
            let bundle = Bundle.module
            let url = bundle.url(forResource: "movie_detail_response", withExtension: "json", subdirectory: "MockResponses")
            if let url {
                let data = try Data(contentsOf: url)
                let dummyResponse = HTTPURLResponse(url: route.baseURL, statusCode: 200, httpVersion: "http2", headerFields: [:])
                completion(data, dummyResponse, nil)
            } else {
                completion(nil, nil, nil)
            }
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        // cancel
    }
}
