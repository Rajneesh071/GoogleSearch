//
//  TestData.swift
//  GoogleSearch
//
//  Created by Rajneesh on 07/03/21.
//  Copyright © 2021 BRRV. All rights reserved.
//

import Foundation
@testable import GoogleSearch

struct TestData {
    static let data: Data = {
        let url = Bundle.main.url(forResource: "TestData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }()
}
