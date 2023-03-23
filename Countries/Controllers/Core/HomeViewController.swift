//
//  HomeViewController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    var tableView = UITableView()
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        configureTableView()
        setTableViewDelegates()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationItem.title = "Countries"
        viewModel.delegate = self
        viewModel.loadCountriesData()
        createObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.reloadTableView(notification:)), name: Constants.homeNotification, object: nil)
    }
    
    @objc
    func reloadTableView(notification: NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.backgroundColor = .systemGray4
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.homeTableViewCell)
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate, HomeTableViewCellDelegate {
    func buttonTintColorChancer(_ indexPath: IndexPath, button: UIButton) {
        if !SavedCountires.shared.savedCountries.contains(where: { $0.name == viewModel.countriesListData[indexPath.row].name }) {
            button.tintColor = .black
            SavedCountires.shared.savedCountries.append(viewModel.countriesListData[indexPath.row])
        } else {
            button.tintColor = .systemGray3
            if let Index = SavedCountires.shared.savedCountries.firstIndex(where: { $0.name == viewModel.countriesListData[indexPath.row].name }) {
                SavedCountires.shared.savedCountries.remove(at: Index)
            }
        }
    }
    
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
        cell.delegate = self
        cell.indexPath = indexPath
        cell.backgroundColor = .systemGray4
        if !SavedCountires.shared.savedCountries.contains(where: { $0.name == viewModel.countriesListData[indexPath.row].name }) {
            cell.starButton.tintColor = .systemGray3
            
        } else {
            cell.starButton.tintColor = .black
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.indexPath = indexPath
        vc.code = viewModel.countriesListData[indexPath.row].code
        vc.configureCountries(countries: viewModel.countriesListData)
        navigationController?.pushViewController(vc, animated: false)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
