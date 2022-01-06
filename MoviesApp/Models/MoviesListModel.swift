//
//  MoviesListModel.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import Foundation

class MoviesListModel: Codable {
    let page: Int
    let results: [MovieInfoModel]
    let totalPages: Int
    let totalResults: Int
}
