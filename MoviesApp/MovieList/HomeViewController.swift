//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- Properties/Objects
    private var viewModel: HomeViewModel?
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Instance Function
    static func instance(viewModel: HomeViewModel) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.viewModel = viewModel
        return viewController
    }

    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindObserver()
        viewModel?.trendingAPI()
        viewModel?.nowPlayingAPIforPage1()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.register(UINib(nibName: "TrendingCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingCollectionTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    //MARK:- Binding work
    private func bindObserver() {
        viewModel?.bindingObserver = { [weak self] (state) in
            guard let strongSelf = self else { return }
            switch state {
            case .nowPlayingCompletion:
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
                
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel?.nowPlayingMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCollectionTableViewCell") as? TrendingCollectionTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(trendingDataModel: <#T##HomeDataModel#>)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
                return UITableViewCell()
            }
            
            viewModel?.checkAndHandleIfPaginationRequired(at: indexPath.row)
            
            if let movieModel = viewModel?.nowPlayingMovieInfoModel(at: indexPath.row){
                cell.configure(dataModel: MovieTableCellViewModel(movieInfoModel: movieModel))
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let movieModel = viewModel.movieInfoModel(at: indexPath.row) {
//            let movieDetailsVC = MovieDetailsViewController(movieModel, managedObjectContext: viewModel.currentMOC())
//            navigationController?.pushViewController(movieDetailsVC, animated: true)
//        }
    }
}
