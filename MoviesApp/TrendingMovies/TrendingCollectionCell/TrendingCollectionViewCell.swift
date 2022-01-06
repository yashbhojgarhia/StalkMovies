//
//  TrendingCollectionViewCell.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 10/08/21.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    //MARK:- Properties/Objects
    private var viewModel: TrendingCollectionViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.layer.cornerRadius = 4
    }
    
    func configure(dataModel: TrendingCollectionViewModel) {
        self.viewModel = dataModel
        guard let viewModel = self.viewModel else { return }
        movieImage.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(named: "placeholderMovie"))
        movieTitle.text = viewModel.movieTitle
    }
    
    

}
