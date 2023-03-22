//
//  SavedPageViewController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

final class SavedViewController: UIViewController {
    
    let notificationKey = Notification.Name(rawValue: Constants.notificationKey)
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        configureTableView()
        setTableViewDelegates()
        createObservers()
        navigationItem.title = "Countries"
        
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(SavedViewController.update(notification:)), name: notificationKey, object: nil)
    }
    
    @objc func update(notification: NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedCountires.shared.myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeTableViewCell) as! HomeTableViewCell
        cell.countryTitleLabel.text = "   " + "\(SavedCountires.shared.myArray[indexPath.row].name)"
        cell.backgroundColor = .systemGray3
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.code = SavedCountires.shared.myArray[indexPath.row].code
        vc.wikiID = SavedCountires.shared.myArray[indexPath.row].wikiDataID
        navigationController?.pushViewController(vc, animated: false)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

