//
//  CountryDataModel+CoreDataProperties.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//
//

import Foundation
import CoreData


extension CountryDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryDataModel> {
        return NSFetchRequest<CountryDataModel>(entityName: "CountryDataModel")
    }

    @NSManaged public var currencyCode: String?
    @NSManaged public var currencyName: String?
    @NSManaged public var flagURL: String?
    @NSManaged public var name: String?

}
