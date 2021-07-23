//
//  AuthorizationEntity.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//

import Foundation
struct RequestTokenResponse: Codable {
    var token: String
    var statusCode: Int
    var statusMessage: String
    var success: Bool
    private enum CodingKeys: String, CodingKey {
        case token = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success = "success"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
        self.success = try container.decode(Bool.self, forKey: .success)
    }
}
struct AccessTokenResponse: Codable {
    var token: String
    var statusCode: Int
    var statusMessage: String
    var success: Bool
    var accountId: String
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success = "success"
        case accountId = "account_id"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.accountId = try container.decode(String.self, forKey: .accountId)
    }
}
struct AccountListResponse: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [AccountListDetail]
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.results = try container.decode([AccountListDetail].self, forKey: .results)
    }
}
struct AccountListDetail: Codable {
    var description: String
    var revenue: String
    var featured: Int
    var name: String
//    private enum CodingKeys: String, CodingKey {
//        case token = "access_token"
//        case statusCode = "status_code"
//        case statusMessage = "status_message"
//        case success = "success"
//        case accountId = "account_id"
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.token = try container.decode(String.self, forKey: .token)
//        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
//        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
//        self.success = try container.decode(Bool.self, forKey: .success)
//        self.accountId = try container.decode(String.self, forKey: .accountId)
//    }
}
