//
//  DetailsEndPoint.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import NetworkCore

enum MoviesAPI {
    case details
}

extension MoviesAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "www.someapi.com")
        else { fatalError("unknown base url") }
        return url
    }

    var path: String {
        "/details"
    }

    var httpMethod: NetworkCore.HTTPMethod {
        .get
    }

    var task: NetworkCore.HTTPTask {
        .request
    }

    var headers: NetworkCore.HTTPHeaders? {
        nil
    }
}
