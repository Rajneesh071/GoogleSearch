//
//  GoogleSearchViewModel.swift
//  GoogleSearch
//
//  Created by Rajneesh on 07/03/21.
//  Copyright © 2021 BRRV. All rights reserved.
//

import Foundation
import Combine

class GoogleSearchViewModel : ObservableObject {
    private var cancellable: AnyCancellable? = nil
    @Published var searchString = ""
    @Published var searchResult: [String] = []
    let provider = ServiceProvider<GoogleSearchService>()
    
    init() {
        /*
         Debounce to stop multiple request if user types a sentance or types in speed.
         **/
        cancellable = AnyCancellable(
            $searchString.removeDuplicates()
                .debounce(for: 0.2, scheduler: DispatchQueue.main)
                .sink { searchText in
                    self.search(item: self.searchString)
        })
    }
    
    func search(item query: String) {
        
        guard query.count > 0 else {
            self.searchResult.removeAll()
            return
        }
        
        provider.load(service: .searchItem(string: query)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let resp):
                do {
                    print(String(decoding: resp, as: UTF8.self))
                    if let json = try JSONSerialization.jsonObject(with: resp, options: []) as? [Any] {
                        if json.count >= 2 && query == json.first as? String {
                            DispatchQueue.main.async {
                                self.searchResult = json[1] as! [String]
                            }
                        }
                    }
                } catch {
                    print("Unable to convert to json")
                }
            case .failure(let error):
                print(error.localizedDescription)
            case .empty:
                print("No data")
            }
        }
    }
}
