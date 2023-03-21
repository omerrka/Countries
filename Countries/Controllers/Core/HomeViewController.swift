//
//  HomePageViewController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

final class HomeViewController: UIViewController, HomeTableViewCellDelegate {
    
    private var starIsSelected = false
        
    var tableView = UITableView()
    
    private let viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        configureTableView()
        setTableViewDelegates()
        navigationItem.title = "Countries"
        viewModel.delegate = self
        viewModel.loadCountriesData()
        
    }
    
    func addFavoriteStarButton(_ indexPath: IndexPath) {
        
        SavedCountires.shared.myArray.append(viewModel.countriesListData[indexPath.row])
        
    }
    
    func removeFavoriteStarButton(_ indexPath: IndexPath) {
        if let Index = SavedCountires.shared.myArray.firstIndex(where: { $0.name == viewModel.countriesListData[indexPath.row].name }) {
            SavedCountires.shared.myArray.remove(at: Index)
            
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.backgroundColor = .systemGray3
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.homeTableViewCell)
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countriesListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeTableViewCell) as! HomeTableViewCell
        cell.setupCountryList(country: viewModel.countriesListData[indexPath.row])
        cell.configureCell(myArray: SavedCountires.shared.myArray, model: viewModel.countriesListData[indexPath.row])
        cell.delegate = self
        cell.indexPath = indexPath
        
        cell.backgroundColor = .systemGray3
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: false)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

