//
//  CountriesViewModel.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import Foundation
import RxSwift

class CountriesViewModel {
    var items = BehaviorSubject<[CountryModel]>(value: [])
    var hideLoading = BehaviorSubject<Bool>(value: false)
    var hideViews = BehaviorSubject<Bool>(value: true)
    private var disposeBag = DisposeBag()
    
    private let dataService: IDataService
    
    init(dataService: IDataService) {
        self.dataService = dataService
    }
    
    func getData() {
        dataService.fetch()
            .subscribe {[weak self] models in
                guard let self else { return }
                self.items.onNext(models)
                self.hideLoading.onNext(true)
                self.hideViews.onNext(false)
            }
            .disposed(by: disposeBag)
    }
}
