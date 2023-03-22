//
//  SavedViewController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

final class SavedViewController: UIViewController {
    
    let savedNotification = Notification.Name(rawValue: Constants.savedNotificationKey)
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        configureTableView()
        setTableViewDelegates()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationItem.title = "Countries"
        createObservers()
        
    }
    
    private func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(SavedViewController.reloadTableView(notification:)), name: savedNotification, object: nil)
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
        tableView.register(SavedTableViewCell.self, forCellReuseIdentifier: Constants.savedTableViewCell)
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource, SavedTableViewCellDelegate {
    
    func removeStarButton(_ indexPath: IndexPath) {
        SavedCountires.shared.myArray.remove(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedCountires.shared.myArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.savedTableViewCell) as! SavedTableViewCell
        cell.countryTitleLabel.text = "   " + "\(SavedCountires.shared.myArray[indexPath.row].name)"
        cell.delegate = self
        cell.indexPath = indexPath
        cell.backgroundColor = .systemGray4
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.code = SavedCountires.shared.myArray[indexPath.row].code
        vc.wikiID = SavedCountires.shared.myArray[indexPath.row].wikiDataID
        vc.indexPath = indexPath
        vc.configureCells(newArray: SavedCountires.shared.myArray)
        navigationController?.pushViewController(vc, animated: false)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

