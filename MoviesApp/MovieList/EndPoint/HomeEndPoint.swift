//
//  HomeEndPoint.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import Foundation
//https://api.themoviedb.org/3/trending/movie/day?api_key=5834bb881be292fd642a695c27959064
enum HomeEndPoint: RequestBuilder {
    
    case nowPlaying(page: String)
    case trending
    
    struct APIKeys {
        static let apiKey = "api_key"
        static let language = "language"
        static let page = "page"
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .trending:
            return "trending/movie/day"
        }
    }
    
    var parameters: RequestParameters? {
        let apiKey = "5834bb881be292fd642a695c27959064"
        var params: RequestParameters = [:]
        switch self {
        case .nowPlaying(let page):
            params[APIKeys.apiKey] = apiKey
            params[APIKeys.language] = "en-US"
            params[APIKeys.page] = page
        case .trending:
            params[APIKeys.apiKey] = apiKey
        }
        return params
    }
}
