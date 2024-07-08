//
//  CommonModels.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

struct GenericAsset: Decodable {
    let url: String?
    let type: AssetType?
    let aspectRatio: Double?

    enum CodingKeys: String, CodingKey {
        case url, type
        case aspectRatio = "aspect_ratio"
    }

    enum AssetType: String, Decodable {
        case image
        case video
        case unknown

        init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let type = try container.decode(String.self)
            self = .init(rawValue: type) ?? .unknown
        }
    }
}
