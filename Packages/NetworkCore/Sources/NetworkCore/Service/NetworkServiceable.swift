//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

typealias NetworkServiceCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkServiceble<EndPoint>: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkServiceCompletion)
    func cancel()
}
