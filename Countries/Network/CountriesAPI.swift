//
//  CountriesAPI.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import Moya

enum CountriesAPI {
    
    case homePageScreen
    
}

extension CountriesAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .homePageScreen:
            return ""
        }
    }
    
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .homePageScreen:
            return .requestParameters(parameters: ["rapidapi-key": Constants.APIKey, "limit": "10"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

