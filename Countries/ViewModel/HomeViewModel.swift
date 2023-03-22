//
//  HomePageViewModel.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func reloadTableView()
    
}

final class HomeViewModel: NSObject {
    
    public weak var delegate: HomeViewModelDelegate?
    
    fileprivate(set) var countriesListData = [CountriesData]()
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadCountriesData() {
        
        networkManager.fetchCountriesResult(completion: { [weak self] result in
            
            guard let strongSelf = self else { return }
            switch result {
            case .success(let countriesData):
                strongSelf.countriesListData = countriesData.data
                strongSelf.delegate?.reloadTableView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
