//
//  AuthorizationEntity.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//

import Foundation
class BaseResponse: Codable {
    /// Estatus de la respuesta del servicio.
    var statusCode: Int
    /// Mensaje que representa el estatus de la respuesta del servicio.
    var statusMessage: String
    /// Bandera que define el exito fracaso del servicio
    var success: Bool
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success = "success"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
        self.success = try container.decode(Bool.self, forKey: .success)
    }
}
class RequestTokenResponse: BaseResponse {
    var token: String
    enum CodingKeys: String, CodingKey {
        case token = "request_token"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        try super.init(from: decoder)
    }
}
class AccessTokenResponse: BaseResponse {
    var token: String
    var accountId: String
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case accountId = "account_id"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.accountId = try container.decode(String.self, forKey: .accountId)
        try super.init(from: decoder)
    }
}
class BaseListResponse: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}

class AccountListResponse: BaseListResponse {
    var results: [AccountListDetail]
    private enum CodingKeys: String, CodingKey {
        case results
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([AccountListDetail].self, forKey: .results)
        try super.init(from: decoder)
    }
}
struct ErrorResponse {
    var message: String
}
struct AccountListDetail: Codable {
    var description: String?
    var revenue: String?
    var featured: Int?
    var name: String?
    var overview: String
}
enum AccountService {
    case list
    case favoriteMovies
    case movieRecommendations
    case movieWatchlist
    case movieRated
    var url: String {
        switch self {
        case .list:
            return TMDb.ApiV4.accountList
        case .favoriteMovies:
            return TMDb.ApiV4.favoriteMovies
        case .movieRecommendations:
            return TMDb.ApiV4.movieRecommendations
        case .movieWatchlist:
            return TMDb.ApiV4.movieWatchlist
        case .movieRated:
            return TMDb.ApiV4.movieRated
        }
    }
}
