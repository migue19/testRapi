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
        static var url: String {
            return baseUrl + "/3"
        }
        static var moviePopular: String {
            return url + "/movie/popular?api_key=" + apiKey + "&language=en-US&page=1"
        }
    }
    struct ApiV4 {
        static var url: String {
            return baseUrl + "/4"
        }
        static var auth: String {
            return url + "/auth"
        }
        static var requestToken: String {
            return auth + "/request_token"
        }
        static var accessToken: String {
            return auth + "/access_token"
        }
        static var account: String {
            return url + "/account/{account_id}"
        }
        static var accountList: String {
            return account + "/lists"
        }
        static var movie: String {
            return account + "/movie"
        }
        static var favoriteMovies: String {
            return movie + "/favorites"
        }
        static var movieRecommendations: String {
            return movie + "/recommendations"
        }
        static var movieWatchlist: String {
            return movie + "/watchlist"
        }
        static var movieRated: String {
            return movie + "/rated"
        }
    }
}
