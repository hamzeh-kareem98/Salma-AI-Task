//
//  CountriesCoreDataService.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import Foundation
import UIKit
import CoreData
import RxSwift

final class CountriesCoreDataService: DataManager {
    
    var hasEmptyData: Bool {
        get {
            return isFirstElementEmpty()
        }
    }
    
    private let context: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer) {
        context = persistentContainer.viewContext
    }
    
    
    func fetch() -> Single<[CountryModel]> {
        
        
        
        return Single.create { single in
            let fetchRequest: NSFetchRequest<CountryDataModel> = CountryDataModel.fetchRequest()
            
            do {
                let results = try self.context.fetch(fetchRequest)
                let mappedResults = results.map({ dataModel in
                    CountryModel(
                        name: NameModel(
                            common: dataModel.name ?? "",
                            official: dataModel.name ?? ""
                        ),
                        currencies:[dataModel.currencyCode ?? "": Currency(
                            name: dataModel.currencyName ?? "",
                            symbol: dataModel.currencyCode ?? ""
                        )],
                        flags: FlagModel(
                            png: dataModel.flagURL ?? ""
                        )
                    )
                })
                                
                single(.success(mappedResults))
                
                return Disposables.create()
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
        
    }
    
    func addData(models: [CountryModel]) {
        
        for model in models {
            let modelToInsert = CountryDataModel(context: context)
            
            modelToInsert.currencyCode = model.currencies?.keys.first
            modelToInsert.currencyName = model.currencies?.first?.value.name
            modelToInsert.flagURL = model.flags.png
            modelToInsert.name = model.name.common
            
            do {
                try context.save()
            } catch {
                print("error-Saving data")
            }
        }

    }
    
    private func isFirstElementEmpty() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CountryDataModel")
        fetchRequest.fetchLimit = 1
        do {
            let result = try context.fetch(fetchRequest)
            return result.isEmpty
        } catch {
            return true
        }
    }
}
