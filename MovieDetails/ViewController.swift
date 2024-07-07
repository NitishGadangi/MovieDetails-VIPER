//
//  ViewController.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import UIKit
import NetworkCore

class ViewController: UIViewController {

    let networkManager = NetworkManager<MovieDetailsAPI>(env: .stage)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.

        networkManager.sendRequest(endPoint: MovieDetailsAPI.details, responseType: TestModel.self) { res in
            print(res)
        }
    }

}

struct TestModel: Codable {
    let header: String
}

enum MovieDetailsAPI {
    case details
}

extension MovieDetailsAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "www.someapi.com") 
        else { fatalError("unknown base url") }
        return url
    }
    
    var path: String {
        return "/details"
    }
    
    var httpMethod: NetworkCore.HTTPMethod {
        return .get
    }
    
    var task: NetworkCore.HTTPTask {
        return .request
    }
    
    var headers: NetworkCore.HTTPHeaders? {
        nil
    }
}

