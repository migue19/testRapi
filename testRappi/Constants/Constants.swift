//
//  Constants.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//

import Foundation

struct TMDb {
    static var imageUrlBase: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    static var urlWeb: String {
        return "https://www.themoviedb.org/auth/access?request_token={request_token}"
    }
    static var apiKey: String {
        return "7bcb00b828c678bab7c681fb33a432ac"
    }
    static var readAccessToken: String {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YmNiMDBiODI4YzY3OGJhYjdjNjgxZmIzM2E0MzJhYyIsInN1YiI6IjYwZjZmZTdlOGQxYjhlMDA1ZWI4NDRkMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.teYAYq8_Kou-4C15kSwIiIZhZZYBsoDgUzjFWQdmucI"
    }
    static var baseUrl: String {
        return "https://api.themoviedb.org"
    }
    struct ApiV3 {
        private static var url: String {
            return baseUrl + "/3"
        }
        private static var movie: String {
            return url + "/movie"
        }
        private static var key: String {
            return "?api_key=" + apiKey + "&language=en-US&page=1"
        }
        static var popular: String {
            return movie + "/popular" + key
        }
        static var topRated: String {
            return movie + "/top_rated" + key
        }
        static var upcoming: String {
            return movie + "/upcoming" + key
        }
        static var nowPlaying: String {
            return movie + "/now_playing" + key
        }
        static var search: String {
            return url + "/search/movie" + key + "&query="
        }
        static var videos: String {
            return movie + "/{movie_id}/videos" + key
        }
    }
}
