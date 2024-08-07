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
        let counriesViewController = CountriesViewController()
        navigationController.pushViewController(counriesViewController, animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
