//
//  DataManager.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/11/24.
//

import Foundation
import RxSwift

protocol DataManager: AnyObject {
    func fetch() -> Single<[CountryModel]>
}
