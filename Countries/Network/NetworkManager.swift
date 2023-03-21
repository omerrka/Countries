//
//  NetworkManager.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//


import Moya

protocol Networkable {
    
    var provider: MoyaProvider<CountriesAPI> { get }
    
    func fetchCountriesResult(completion: @escaping (Result<Countries, Error>) -> ())
    
}

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<CountriesAPI>(plugins: [NetworkLoggerPlugin()])

        func fetchCountriesResult(completion: @escaping (Result<Countries, Error>) -> ()) {
            request(target: .homePageScreen, completion: completion)
        }
    }


private extension NetworkManager {
    private func request<T: Decodable>(target: CountriesAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


