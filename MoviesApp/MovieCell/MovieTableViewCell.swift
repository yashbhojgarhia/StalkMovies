//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 10/08/21.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    //MARK:- Properties/Objects
    private var viewModel: MovieTableCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.layer.cornerRadius = 4
    }

    func configure(dataModel: MovieTableCellViewModel) {
        self.viewModel = dataModel
        guard let viewModel = self.viewModel else { return }
        movieImage.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(named: "placeholderMovie"))
        titleLabel.text = viewModel.movieTitle
        subtitleLabel.text = viewModel.movieOverview
    }
    
    
}
