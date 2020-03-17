//
//  FutureForecastVC.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FutureForecastVC: UIViewController, MVVMViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FutureForecastVMProtocol!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Forecast")
        setupUI()
        setupObservables()
        viewModel.loadForecast()
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.AppColor.backgroundColor
        setupForecastTableView()
    }
    
    func setupForecastTableView() {
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle:nil), forCellReuseIdentifier:  ForecastTableViewCell.cellIdentifier)
        tableView.backgroundColor = UIColor.AppColor.backgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupObservables() {
        viewModel.statusMessageHandler.subscribe(onNext: { (statusMessage) in
            self.handleStatusMessage(statusMessage)
        }).disposed(by: disposeBag)
        
        viewModel.didGetLocationTitle.subscribe(onNext: { (title) in
            self.setupNavigationBar(title: title)
        }).disposed(by: disposeBag)

        viewModel.screenState.subscribe(onNext: { (screenState) in
            switch screenState {
            case .empty:
                self.showActivitiIndicator(value: false)
            case .loading:
                self.showActivitiIndicator(value: true)
            case .showingForecast:
                self.showActivitiIndicator(value: false)
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension FutureForecastVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.cellIdentifier, for: indexPath) as! ForecastTableViewCell
        if let cellVM = viewModel.forecastCellVM(at: indexPath) {
            cell.config(with: cellVM)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
//        label.textColor = UIColor.AppColor.silver
        label.text = viewModel.title(for: section)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColor.headerTitleColor
        label.font = UIFont.AppFonts.sfuitTextMedium(with: 18)
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.AppColor.sectionHeaderBackgroundColor
        containerView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        return containerView
    }
}
