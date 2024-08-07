//
//  DetailsModels.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

struct DetailsResponseModel: Decodable {
    let header: String?
    let items: [DetailsTemplateProperties]?
}

enum DetailsTemplateType: String, Decodable {
    case assetCarouselCard = "asset_carousel_card"
    case titleLocationCard = "title_location_card"
    case countdownTimerCard = "countdown_timer_card"
    case socialProofingCard = "social_proofing_card"
    case additionalDetailsCard = "additional_details_card"
    case unknown

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let type = try container.decode(String.self)
        self = .init(rawValue: type) ?? .unknown
    }
}

enum DetailsTemplateProperties: Decodable {
    case assetCarouselCard(AssetCarouselTemplateProperties)
    case titleLocationCard(TitleLocationTemplateProperties)
    case countdownTimerCard(CountDownTimerTemplateProperties)
    case socialProofingCard(SocialProofingTemplateProperties)
    case additionalDetailsCard(AdditionalDetailsTemplateProperties)
    case unknown

    var templateType: DetailsTemplateType {
        switch self {
            case .assetCarouselCard:
                return .assetCarouselCard
            case .titleLocationCard:
                return .titleLocationCard
            case .countdownTimerCard:
                return .countdownTimerCard
            case .socialProofingCard:
                return .socialProofingCard
            case .additionalDetailsCard:
                return .additionalDetailsCard
            case .unknown:
                return .unknown
        }
    }

    enum CodingKeys: String, CodingKey {
        case templateType = "template_type"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let tempType = try? container.decode(DetailsTemplateType.self, forKey: .templateType) else {
            self = .unknown
            return
        }

        let objContainer = try decoder.singleValueContainer()
        switch tempType {
            case .assetCarouselCard:
                let templateProps = try objContainer.decode(AssetCarouselTemplateProperties.self)
                self = .assetCarouselCard(templateProps)
            case .titleLocationCard:
                let templateProps = try objContainer.decode(TitleLocationTemplateProperties.self)
                self = .titleLocationCard(templateProps)
            case .countdownTimerCard:
                let templateProps = try objContainer.decode(CountDownTimerTemplateProperties.self)
                self = .countdownTimerCard(templateProps)
            case .socialProofingCard:
                let templateProps = try objContainer.decode(SocialProofingTemplateProperties.self)
                self = .socialProofingCard(templateProps)
            case .additionalDetailsCard:
                let templateProps = try objContainer.decode(AdditionalDetailsTemplateProperties.self)
                self = .additionalDetailsCard(templateProps)
            case .unknown:
                self = .unknown
        }
    }
}

struct AssetCarouselTemplateProperties: Decodable {
    let assets: [GenericAsset]?
}

struct TitleLocationTemplateProperties: Decodable {
    let tag: String?
    let title: String?
    let subTitle: String?
    let location: TextWithAssetModel?
    let dateTime: TextWithAssetModel?

    enum CodingKeys: String, CodingKey {
        case tag, title, location
        case subTitle = "sub_title"
        case dateTime = "date_time"
    }
}

struct TextWithAssetModel: Decodable {
    let asset: GenericAsset?
    let text: String?
}

struct CountDownTimerTemplateProperties: Decodable {
    let header: String?
    let endTime: Double

    enum CodingKeys: String, CodingKey {
        case header
        case endTime = "end_time"
    }
}

struct SocialProofingTemplateProperties: Decodable {
    let description: String?
    let assets: [GenericAsset]?
}

struct AdditionalDetailsTemplateProperties: Decodable {
    let details: [AdditionalInfoItem]?
}

struct AdditionalInfoItem: Decodable {
    let header: String?
    let body: String?
}
