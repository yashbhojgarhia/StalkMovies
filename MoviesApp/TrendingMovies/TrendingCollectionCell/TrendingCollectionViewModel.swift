//
//  TrendingCollectionViewModel.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 10/08/21.
//

import UIKit

class TrendingCollectionViewModel {
    
    //MARK:- Properties
    private var movieInfoModel: MovieInfoModel
    
    init(movieInfoModel: MovieInfoModel) {
        self.movieInfoModel = movieInfoModel
    }
    
    var imageURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(movieInfoModel.posterPath ?? "")")
    }
    
    var movieTitle: String {
        return movieInfoModel.title
    }

}
