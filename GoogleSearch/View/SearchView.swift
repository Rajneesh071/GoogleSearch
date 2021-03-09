//
//  SearchView.swift
//  GoogleSearch
//
//  Created by Rajneesh on 06/03/21.
//  Copyright © 2021 BRRV. All rights reserved.
//

import SwiftUI

struct SearchView : View {
    @State private var query: String = ""
    @EnvironmentObject var googleSearchVM: GoogleSearchViewModel
    @State var showSuggestions = true
    @State var showWebView = false
    
    var body: some View {
        
        VStack {
            VStack {
                Image("google").resizable().scaledToFit()
                    .padding(.top, 100)
                    .padding()
                
                SearchBar(text: $googleSearchVM.searchString)
                Spacer()
                
                List {
                    ForEach(googleSearchVM.searchResult, id: \.self) { repo in
                        Text(repo).onTapGesture {
                            self.query = repo
                            self.showWebView.toggle()
                        }
                    }
                }.opacity(googleSearchVM.searchResult.count>0 ? 1 : 0)
                    .sheet(isPresented: $showWebView) {
                        ContentView2(searchString: self.query)
                }
            }
        }
    }
    
    private func fetch() {
        googleSearchVM.search(item: query)
    }
}
