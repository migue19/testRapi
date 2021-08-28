//
//  MoviesEntity.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 28/08/21.
//
enum MoviesService {
    case popular
    case topRated
    var url: String {
        switch self {
        case .popular:
            return TMDb.ApiV3.popular
        case .topRated:
            return TMDb.ApiV3.topRated
        }
    }
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}
/// Estructura que contiene las respuestas de los servicios de películas
struct MoviesResponseEntity {
    var section: MoviesService
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
