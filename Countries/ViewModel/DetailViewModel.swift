//
//  DetailViewModel.swift
//  Countries
//
//  Created by Ömer Karabulut on 21.03.2023.
//

import Moya

protocol DetailViewModelDelegate: AnyObject {
    func configureDetailView()
    
}

final class DetailViewModel: NSObject {
    
    fileprivate(set) var countryDetail: CountryDetailData?
    public weak var delegate: DetailViewModelDelegate?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadCountryDetailData(code: String) {
        
        networkManager.fetchCountryDetailResult(code: code ,completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let countryDetailData):
                strongSelf.countryDetail = countryDetailData.data
                strongSelf.delegate?.configureDetailView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
