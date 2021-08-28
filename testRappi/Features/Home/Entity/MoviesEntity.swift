//
//  MoviesEntity.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 28/08/21.
//
enum TypeMovieV3 {
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
