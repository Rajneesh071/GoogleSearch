//
//  GoogleSearchService.swift
//  GoogleSearch
//
//  Created by Rajneesh on 06/03/21.
//  Copyright © 2021 BRRV. All rights reserved.
//

import Foundation

enum GoogleSearchService {
    case searchItem(string: String)
}

extension GoogleSearchService: Service {
    var baseURL: String {
        return "https://www.google.com"
    }

    var path: String {
        switch self {
        case .searchItem(_):
            return "/complete/search"
        }
    }

    var parameters: [String: Any]? {
        // default params
        var params: [String: Any] = [:]
        
        switch self {
        case .searchItem(let item):
            params["output"] = "firefox"
            params["hl"] = "en"
            params["q"] = item
        }
        return params
    }

    var method: ServiceMethod {
        return .get
    }
}
