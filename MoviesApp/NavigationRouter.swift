//
//  NavigationRouter.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import UIKit

class NavigationRouter {
    
    static func attachLaunchFlow() {
        let launchViewController: LaunchViewController = LaunchViewController.instance()
        let targetVC = UINavigationController(rootViewController: launchViewController)
        targetVC.setNavigationBarHidden(true, animated: false)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        window.rootViewController = targetVC
        window.makeKeyAndVisible()
    }
    
    static func tabBarFlow() {
        let tabBarVC = UITabBarController()
        
        
        let nowPlayingVC = UINavigationController(rootViewController: HomeViewController.instance(viewModel: HomeViewModel(homeAPIManager: HomeAPIManagerImpl())))
        let trendingVC = UINavigationController(rootViewController: MovieListViewController.instance(viewModel: MovieListViewModel(listingType: .trending)))
        let searchVC = UINavigationController(rootViewController: MovieListViewController.instance(viewModel: MovieListViewModel(listingType: .search)))
        let savedVC = UINavigationController(rootViewController: MovieListViewController.instance(viewModel: MovieListViewModel(listingType: .saved)))
        
        let nowPlayingTabBarItem = UITabBarItem(title: ListingTypeEnum.nowPlaying.rawValue, image: UIImage(systemName: "play.fill"), tag: 0)
        let trendingTabBarItem = UITabBarItem(title: ListingTypeEnum.trending.rawValue, image: UIImage(systemName: "flame.fill"), tag: 1)
        let searchTabBarItem = UITabBarItem(title: ListingTypeEnum.search.rawValue, image: UIImage(systemName: "magnifyingglass"), tag: 2)
        let savedTabBarItem = UITabBarItem(title: ListingTypeEnum.saved.rawValue, image: UIImage(systemName: "bookmark.fill"), tag: 3)
        
        nowPlayingVC.tabBarItem = nowPlayingTabBarItem
        trendingVC.tabBarItem = trendingTabBarItem
        searchVC.tabBarItem = searchTabBarItem
        savedVC.tabBarItem = savedTabBarItem
        
        tabBarVC.setViewControllers([nowPlayingVC, trendingVC, searchVC, savedVC], animated: false)
        
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        window.rootViewController = tabBarVC
        
    }
    
}

