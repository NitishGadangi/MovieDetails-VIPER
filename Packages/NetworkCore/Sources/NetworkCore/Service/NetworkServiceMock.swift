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
            let url = bundle.url(forResource: route.mockResponseFileName, withExtension: "json", subdirectory: "MockResponses")
            if let url {
                let data = try Data(contentsOf: url)
                let dummyResponse = getDummySuccessResponse(endPoint: route)
                completion(data, dummyResponse, nil)
            } else {
                let dummyResponse = getDummyErrorResponse(endPoint: route)
                completion(nil, dummyResponse, nil)
            }
        } catch {
            completion(nil, nil, error)
        }
    }

    func cancel() {
        // Nothing to do here
    }
}

private extension NetworkServiceMock {
    func getDummySuccessResponse(endPoint: EndPoint) -> HTTPURLResponse? {
        HTTPURLResponse(url: endPoint.baseURL,
                        statusCode: 200,
                        httpVersion: "http2",
                        headerFields: endPoint.headers ?? [:])
    }

    func getDummyErrorResponse(endPoint: EndPoint) -> HTTPURLResponse? {
        HTTPURLResponse(url: endPoint.baseURL,
                        statusCode: 400,
                        httpVersion: "http2",
                        headerFields: endPoint.headers ?? [:])
    }
}
