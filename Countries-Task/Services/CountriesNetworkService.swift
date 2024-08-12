//
//  CountriesNetworkService.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import Foundation
import Alamofire
import RxSwift

final class CountriesNetworkService: DataManager {
    
    func fetch() -> Single<[CountryModel]> {
        
        return Single.create { single in
            AF.request("https://restcountries.com/v3.1/all").response { response in
                if response.error != nil {
                    single(.failure(response.error!))
                }
                
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedCountryModels = try decoder.decode([CountryModel].self, from: data)
                        
                        single(.success(decodedCountryModels))
                    }
                    catch {
                        single(.failure(error))
                    }
                }
                
            }
            
            return Disposables.create()
        }
        
    }
}
