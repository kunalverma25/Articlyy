//
//  ArticleModels.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation

struct ArticleData: Codable {
    let resourceType: String?
    let articlesCount: Int?
    let links: WelcomeLinks?
    let embedded: Embedded?
    
    enum CodingKeys: String, CodingKey {
        case resourceType, articlesCount
        case links = "_links"
        case embedded = "_embedded"
    }
}

struct Embedded: Codable {
    let filters: [Filter]?
    let articles: [Article]?
}

struct Article: Codable {
    let description: String?
    let prevPrice: Price?
    let manufacturePrice: String?
    let delivery: Delivery?
    let brand: Brand?
    let media: [Media]?
    let assemblyService, availability, url, energyClass: String?
    let sku, title: String?
    let price: Price?
    let metadata: Metadata?
    let links: ArticleLinks?
    var isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case description, prevPrice, manufacturePrice, delivery, brand, media, assemblyService, availability, url, energyClass, sku, title, price
        case metadata = "_metadata"
        case links = "_links"
    }
}

struct Brand: Codable {
    let id, title: String?
    let logo: [String]?
    let description: String?
}

struct Delivery: Codable {
    let time: Time?
    let type: DeliveryType?
    let terms, deliveredBy: String?
    let text, typeLabelLink: String?
}

struct Time: Codable {
    let renderAs: RenderAs?
    let amount: String?
    let units: Units?
}

enum RenderAs: String, Codable {
    case days = "days"
    case weeks = "weeks"
}

enum Units: String, Codable {
    case days = "days"
}

enum DeliveryType: String, Codable {
    case furnitureshipping = "furnitureshipping"
    case parcelservice = "parcelservice"
}

struct ArticleLinks: Codable {
    let linksSelf, webShopURL: Next?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case webShopURL = "webShopUrl"
    }
}

struct Next: Codable {
    let href: String?
}

struct Media: Codable {
    let uri: String?
    let mimeType: MIMEType?
    let type: String?
    let priority: Int?
    let size: String?
}

enum MIMEType: String, Codable {
    case imagePNG = "image/png"
}

struct Metadata: Codable {
    let type: MetadataType?
}

enum MetadataType: String, Codable {
    case article = "article"
    case collection = "collection"
    case color = "color"
    case colorOption = "colorOption"
    case option = "option"
    case range = "range"
}

struct Price: Codable {
    let amount: String?
    let currency: Currency?
    let isRecommendedRetailPrice: Bool?
}

enum Currency: String, Codable {
    case eur = "EUR"
}

struct Filter: Codable {
    let values: [Value]?
    let id: String?
    let priority: Int?
    let title: String?
    let metadata: Metadata?
    let min, max, currentMin, currentMax: Int?
    let unit: String?
    
    enum CodingKeys: String, CodingKey {
        case values, id, priority, title
        case metadata = "_metadata"
        case min, max, currentMin, currentMax, unit
    }
}

struct Value: Codable {
    let colorCode, colorImage: String?
    let id: ID?
    let priority: Int?
    let title: String?
    let metadata: Metadata?
    
    enum CodingKeys: String, CodingKey {
        case colorCode, colorImage, id, priority, title
        case metadata = "_metadata"
    }
}

enum ID: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct WelcomeLinks: Codable {
    let linksSelf: Next?
    let articles: [Next]?
    let next: Next?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case articles, next
    }
}

