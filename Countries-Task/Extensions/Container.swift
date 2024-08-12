//
//  Container.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import UIKit

extension Container {

    func registerDependencies() {
        registerServices()
        registerViewModels()
    }
    
    
    private func registerServices() {
        if let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            register(CountriesCoreDataService.self) { resolver in
                return CountriesCoreDataService(persistentContainer: persistentContainer)
            }
        }
        
        autoregister(CountriesNetworkService.self, initializer: CountriesNetworkService.init)
        
        if let coreDataService = resolve(CountriesCoreDataService.self),
           let networkService = resolve(CountriesNetworkService.self) {
            
            register(IDataService.self) { resolver in
                return DataService(coreDataService: coreDataService, networkService: networkService)
            }
            
        }

    }
    
    private func registerViewModels() {
        autoregister(CountriesViewModel.self, initializer: CountriesViewModel.init)
    }
}

