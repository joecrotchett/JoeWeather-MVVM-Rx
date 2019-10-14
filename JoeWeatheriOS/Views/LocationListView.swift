//
//  LocationListView.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit
import RxSwift
import RxCocoa

final class LocationListView: NiblessView {
    
    private var viewModel: LocationListViewModel
    private let disposeBag = DisposeBag()
    private var hierarchyNotReady = true
    
    var locations = BehaviorSubject<[Location]>(value: [])
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseIdentifier)
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = Color.red
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    init(frame: CGRect = .zero,
         viewModel: LocationListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        viewModel.locations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected view model zip codes observable error.") })
            .drive(locations)
            .disposed(by: disposeBag)
        
        self.locations
            .asDriver(onErrorRecover: { _ in fatalError("Encountered unexpected zip codes observable error.") })
            .drive(onNext: { [weak self] _ in self?.tableView.reloadData() })
            .disposed(by: disposeBag)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        
        self.addSubview(self.tableView)
        hierarchyNotReady = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
}

extension LocationListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try locations.value().count
        } catch {
            fatalError("Error reading value from zip codes subject.")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            let cell: LocationCell = tableView.dequeue(for: indexPath)
            let location = try locations.value()[indexPath.row]
            cell.configure(with: location)
            return cell
        } catch {
            fatalError("Error reading value from location subject.")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let location = try locations.value()[indexPath.row]
                self.viewModel.delete(location: location)
            } catch {
                fatalError("Error reading value from location subject.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension LocationListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let location = try locations.value()[indexPath.row]
            self.viewModel.selected(location: location)
        } catch {
            fatalError("Error reading value from location subject.")
        }
    }
}
