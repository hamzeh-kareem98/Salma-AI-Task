//
//  Coordinator.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import UIKit

protocol Coordinator {

    var navigationController: UINavigationController { get set }

    func start()
}
