//
//  MovieInfoModel.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import Foundation

class MovieInfoModel: Codable {
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Float
    let popularity: Float
    let id: Int
    let title: String
    let overview: String
}
