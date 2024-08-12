//
//  CountriesViewController.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class CountriesViewController: UIViewController {
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
        tableView.rowHeight = 104
        tableView.separatorStyle = .singleLine
        
        tableView.register(CountryCell.self, forCellReuseIdentifier: "countryCell")
        return tableView
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel: CountriesViewModel
    
    init(viewModel: CountriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activityIndicatorView.startAnimating()
        
        setupView()
        setupConstraints()
        setupViewModelsFuncs()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    
    
    private func setupView() {
        view.addSubview(activityIndicatorView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                
                activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        )
    }
    
    private func setupViewModelsFuncs() {
        viewModel.items
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "countryCell", cellType: CountryCell.self)) { row, element, cell in
                    cell.configure(with: element)
                }
                .disposed(by: disposeBag)
        
        viewModel.hideViews
            .bind(to: tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.hideLoading
            .bind(to: activityIndicatorView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

