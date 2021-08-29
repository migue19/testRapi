//
//  testRappiTests.swift
//  testRappiTests
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//

import XCTest
@testable import testRappi

class TestRappiTests: XCTestCase {
    private var movies: [MoviesResponseEntity] = []
    override func setUp() {
        let popular = mockPopular()
        self.movies = [
            MoviesResponseEntity(section: .popular, movies: popular, error: nil)
        ]
    }
    override func tearDown() {
        self.movies = []
    }
    func testGetMovies() {
        let aux = self.movies
        print(aux)
    }
    func testGetMoviesFor(section: TypeMovieV3) -> [MovieListDetail] {
        if let data = movies.filter({ $0.section == section }).first, let movies = data.movies {
            return movies.results
        } else {
            return [MovieListDetail]()
        }
    }
    func mockPopular() -> MovieListResponse? {
        if let path = Bundle.main.path(forResource: "popular_mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let entity = self.decode(MovieListResponse.self, from: data, serviceName: "Popular Movie Service") {
                    return entity
                }
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    func decode<T: Codable>(_ type: T.Type, from data: Data, serviceName: String) -> T? {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("DecodingError in \(serviceName) - Context:", context.codingPath)
        } catch let DecodingError.keyNotFound(key, context) {
            print("DecodingError in \(serviceName) - Key '\(key)' not found:", context.debugDescription)
            print("DecodingError in \(serviceName) - CodingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("DecodingError in \(serviceName) - Value '\(value)' not found:", context.debugDescription)
            print("DecodingError in \(serviceName) - CodingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("DecodingError in \(serviceName) - Type '\(type)' mismatch:", context.debugDescription)
            print("DecodingError in \(serviceName) - CodingPath:", context.codingPath)
        } catch {
            print("DecodingError in \(serviceName) - Error: ", error)
        }
        return nil
    }
}
