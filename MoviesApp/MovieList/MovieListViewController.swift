//
//  MovieListViewController.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    //MARK:- Properties/Objects
    private var viewModel: MovieListViewModel?
    
    //MARK:- Instance Function
    static func instance(viewModel: MovieListViewModel) -> MovieListViewController {
        let viewController = MovieListViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.viewModel = viewModel
        return viewController
    }

    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewModel?.backgroundColor()
        title = viewModel?.titleLabel
    }

}
