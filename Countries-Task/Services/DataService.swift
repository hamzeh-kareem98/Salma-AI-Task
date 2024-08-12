//
//  DataFetchingService.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import Foundation
import PromiseKit
import RxSwift

protocol IDataService {
    func fetch() -> Single<[CountryModel]>
}

final class DataService: IDataService {
    
    private let coreDataService : CountriesCoreDataService
    private let networkService: CountriesNetworkService
    
    init(coreDataService: CountriesCoreDataService, networkService: CountriesNetworkService) {
        self.coreDataService = coreDataService
        self.networkService = networkService
    }
    
    func fetch() -> Single<[CountryModel]> {
        
        if coreDataService.hasEmptyData {
            return networkService.fetch()
        }
        else {
            return coreDataService.fetch()
        }
    }

}
