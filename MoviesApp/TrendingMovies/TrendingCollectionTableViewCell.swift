//
//  TrendingCollectionTableViewCell.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 10/08/21.
//

import UIKit

class TrendingCollectionTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Properties/Objects
    var trendingDataModel: HomeDataModel = HomeDataModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "TrendingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(trendingDataModel: HomeDataModel) {
        self.trendingDataModel = trendingDataModel
        collectionView.reloadData()
    }
}

extension TrendingCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped me")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingDataModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath ) as? TrendingCollectionViewCell {
            guard let index = self.index else { return UICollectionViewCell() }
            cell.setItem(item: ItemCategoryModel.itemCategory[index].categoryItems[indexPath.row])
            print(index)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return collectionView.frame.size
    }
    
    
}
