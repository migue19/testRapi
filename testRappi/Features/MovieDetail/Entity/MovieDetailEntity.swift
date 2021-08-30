//
//  MovieDetailEntity.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//

import Foundation

struct VideoList: Codable {
    var identifier: Int
    var results: [VideoListDetail]
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case results
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.results = try container.decode([VideoListDetail].self, forKey: .results)
    }
}
struct VideoListDetail: Codable {
    var iso639: String
    var iso3166: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var published: String
    var identifier: String
    private enum CodingKeys: String, CodingKey {
        case iso639 = "iso_639_1"
        case iso3166 = "iso_3166_1"
        case identifier = "id"
        case name
        case key
        case site
        case size
        case type
        case official
        case published = "published_at"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(String.self, forKey: .identifier)
        self.iso639 = try container.decode(String.self, forKey: .iso639)
        self.iso3166 = try container.decode(String.self, forKey: .iso3166)
        self.name = try container.decode(String.self, forKey: .name)
        self.key = try container.decode(String.self, forKey: .key)
        self.site = try container.decode(String.self, forKey: .site)
        self.size = try container.decode(Int.self, forKey: .size)
        self.type = try container.decode(String.self, forKey: .type)
        self.official = try container.decode(Bool.self, forKey: .official)
        self.published = try container.decode(String.self, forKey: .published)
    }
}
