//
//  LaunchViewController.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import UIKit

class LaunchViewController: UIViewController {
    
    static func instance() -> LaunchViewController {
        let viewController = LaunchViewController()
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let originalFrame = self.view.frame
        UIView.animate(withDuration: 2) { [weak self] in
            self?.view.frame = CGRect.init(x: 0, y: -originalFrame.size.height, width: originalFrame.size.width, height: originalFrame.size.height)
        } completion: { _ in
            NavigationRouter.tabBarFlow()
        }
    }

}
