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
            return apiKey + "&language=en-US&page=1"
        }
        static var popular: String {
            return movie + "/popular?api_key=" + key
        }
        static var topRated: String {
            return movie + "/top_rated?api_key=" + key
        }
        static var upcoming: String {
            return movie + "/upcoming?api_key=" + key
        }
        static var nowPlaying: String {
            return movie + "/now_playing?api_key=" + key
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
