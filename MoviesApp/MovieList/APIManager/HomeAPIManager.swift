//
//  HomeAPIManager.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import Foundation

protocol HomeAPIManager {
    func nowPlayingAPI(page: String, completion: ((Result<MoviesListModel,Error>) -> Void)?)
    func trendingAPI(completion: ((Result<MoviesListModel,Error>) -> Void)?)
}

class HomeAPIManagerImpl: HomeAPIManager {
    private var requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler = RequestHandler()) {
        self.requestHandler = requestHandler
    }
    
    func nowPlayingAPI(page: String, completion: ((Result<MoviesListModel,Error>) -> Void)?) {
        let request = HomeEndPoint.nowPlaying(page: page)
        requestHandler.sendRequest(MoviesListModel.self, request: request) { (result) in
            switch result {
            case .success(let model):
                completion?(.success(model))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func trendingAPI(completion: ((Result<MoviesListModel,Error>) -> Void)?) {
        let request = HomeEndPoint.trending
        requestHandler.sendRequest(MoviesListModel.self, request: request) { (result) in
            switch result {
            case .success(let model):
                completion?(.success(model))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
