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
        case results = "results"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([AccountListDetail].self, forKey: .results)
        try super.init(from: decoder)
    }
}
class MovieListResponse: BaseListResponse {
    var results: [MovieListDetail]
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([MovieListDetail].self, forKey: .results)
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
struct MovieListDetail: Codable {
    var id: Int
    var overview: String
    var posterPath: String
    var adult: Bool
    var releaseDate: String
    var genreIds: [Int]
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String
    var popularity: Float
    var voteCount: Int
    var video: Bool
    var voteAverage: Float
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case adult = "adult"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.title = try container.decode(String.self, forKey: .title)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.popularity = try container.decode(Float.self, forKey: .popularity)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Float.self, forKey: .voteAverage)
    }
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
