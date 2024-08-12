//
//  MainCoordinator.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
         let viewModel = SceneDelegate.container.resolve(CountriesViewModel.self)!
        
        let counriesViewController = CountriesViewController(viewModel: viewModel)
        navigationController.pushViewController(counriesViewController, animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
