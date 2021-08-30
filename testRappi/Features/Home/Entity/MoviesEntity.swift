//
//  MoviesEntity.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 28/08/21.
//
enum TypeMovieV3: CaseIterable {
    case popular
    case topRated
    case upcoming
    case nowPlaying
    var url: String {
        switch self {
        case .popular:
            return TMDb.ApiV3.popular
        case .topRated:
            return TMDb.ApiV3.topRated
        case .upcoming:
            return TMDb.ApiV3.upcoming
        case .nowPlaying:
            return TMDb.ApiV3.nowPlaying
        }
    }
    var title: String {
        switch self {
        case .popular:
            return "section_popular".localized
        case .topRated:
            return "section_top_rated".localized
        case .upcoming:
            return "section_upcoming".localized
        case .nowPlaying:
            return "section_now_playing".localized
        }
    }
}
enum SearchType {
    case search
    var url: String {
        switch self {
        case .search:
            return TMDb.ApiV3.search
        }
    }
}
/// Estructura que contiene las respuestas de los servicios de películas
struct MoviesResponseEntity {
    var section: TypeMovieV3
    var movies: MovieListResponse?
    var error: String?
}
class MovieListResponse: BaseListResponse {
    var results: [MovieListDetail]
    private enum CodingKeys: String, CodingKey {
        case results
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([MovieListDetail].self, forKey: .results)
        try super.init(from: decoder)
    }
}
struct MovieListDetail: Codable {
    var identifier: Int
    var overview: String
    var posterPath: String?
    var adult: Bool
    var releaseDate: String
    var genreIds: [Int]
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Float
    var voteCount: Int
    var video: Bool
    var voteAverage: Float
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
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
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.title = try container.decode(String.self, forKey: .title)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.popularity = try container.decode(Float.self, forKey: .popularity)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Float.self, forKey: .voteAverage)
    }
}
