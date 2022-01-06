//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import UIKit

enum ListingTypeEnum: String {
    case nowPlaying = "Now Playing"
    case trending = "Trending"
    case search = "Search"
    case saved = "Saved"
}

class MovieListViewModel {
    
    //MARK:- Properties/Objects
    private var listingType: ListingTypeEnum = .nowPlaying //Giving default type as first item
    
    //MARK:- Init
    init(listingType: ListingTypeEnum) {
        self.listingType = listingType
    }
    
    func backgroundColor() -> UIColor {
        switch listingType {
        case .nowPlaying:
            return .red
        case .trending:
            return .blue
        case .search:
            return .green
        case .saved:
            return .yellow
        }
    }
    
    var titleLabel: String {
        return listingType.rawValue
    }

}
