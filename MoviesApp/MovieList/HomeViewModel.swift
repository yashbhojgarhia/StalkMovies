//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import UIKit

//MARK:- DataModel
class HomeDataModel {
    var movieList: [MovieInfoModel]
    var currentPageNumber: Int
    var totalPages: Int
    
    init() {
        movieList = []
        currentPageNumber = 0
        totalPages = 100 // default upper limit
    }
}

//MARK:- ObserverEnum
enum HomeViewModelObserver {
    case nowPlayingCompletion
}

class HomeViewModel {
    
    //MARK:- Properties/Objects
    private var homeAPIManager: HomeAPIManager
    var bindingObserver: ((HomeViewModelObserver) -> Void)?
    private var nowPlayingDataModel: HomeDataModel
    private var isProcessing: Bool
    private var trendingDataModel: HomeDataModel
    
    //MARK:- Init
    init(homeAPIManager: HomeAPIManager) {
        self.homeAPIManager = homeAPIManager
        self.nowPlayingDataModel = HomeDataModel()
        self.isProcessing = false
        self.trendingDataModel = HomeDataModel()
    }
    
    //MARK:- API Hits
    func nowPlayingAPIforPage1() {
        isProcessing = true
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.homeAPIManager.nowPlayingAPI(page: String(1)) { (result) in
                switch result {
                case .success(let model):
                    strongSelf.handleNowPlayingSucess(movieListModel: model)
                    
                case .failure:
                    strongSelf.updateNowPlayingWithCachedMovieList()
                }
                strongSelf.isProcessing = false
            }
        }
    }
    
    private func nowPlayingAPIforNextPage() {
        isProcessing = true
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.homeAPIManager.nowPlayingAPI(page: String(strongSelf.nowPlayingDataModel.currentPageNumber + 1)) { (result) in
                switch result {
                case .success(let model):
                    strongSelf.handleNowPlayingSucess(movieListModel: model)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                strongSelf.isProcessing = false
            }
        }
    }
    
    func trendingAPI() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.homeAPIManager.trendingAPI { (result) in
                switch result {
                case .success(let model):
                    print(model)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:- Helper Methods
    private func handleNowPlayingSucess(movieListModel: MoviesListModel) {
        nowPlayingDataModel.currentPageNumber = movieListModel.page
        nowPlayingDataModel.totalPages = movieListModel.totalPages
        
        updateNowPlayingMovieList(movieListModel.results)
        bindingObserver?(.nowPlayingCompletion)
        
        MoviesListLocalManager.saveCurrentMoviesList(nowPlayingDataModel.movieList, entityName: ConstantKeys.NOW_PLAYING_LOCAL)
    }
    
    private func updateNowPlayingMovieList(_ movieList: [MovieInfoModel]) {
        for movieInfoModel in movieList {
            nowPlayingDataModel.movieList.append(movieInfoModel)
        }
    }
    
    private func updateNowPlayingWithCachedMovieList() {
        let movieModelList = MoviesListLocalManager.fetchMoviesList(entityName: ConstantKeys.NOW_PLAYING_LOCAL)
        updateNowPlayingMovieList(movieModelList)
        bindingObserver?(.nowPlayingCompletion)
    }
    
    func nowPlayingMoviesCount() -> Int {
        return nowPlayingDataModel.movieList.count
    }
    
    func nowPlayingMovieInfoModel(at index: Int) -> MovieInfoModel? {
        return nowPlayingDataModel.movieList[index]
    }
    
    // MARK:- Pagination
    func checkAndHandleIfPaginationRequired(at row: Int) {
        if (row + 1 == nowPlayingDataModel.movieList.count) && (nowPlayingDataModel.currentPageNumber != nowPlayingDataModel.totalPages) {
            handlePaginationRequired()
        }
    }
    
    private func handlePaginationRequired() {
        if !isProcessing && nowPlayingDataModel.currentPageNumber != 0 {
            isProcessing = true
            nowPlayingAPIforNextPage()
        }
    }
}
