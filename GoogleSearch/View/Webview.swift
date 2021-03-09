//
//  Webview.swift
//  GoogleSearch
//
//  Created by Rajneesh on 08/03/21.
//  Copyright © 2021 BRRV. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentView2: View {
    let searchString : String
    var body: some View {
        Webview(url: URL(string: "https://www.google.com/search?q=\(self.getCompatibleSearchString())")!)
    }
    
    func getCompatibleSearchString() -> String {
        return self.searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

struct Webview: UIViewRepresentable {
	let url: URL

	func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
		let webview = WKWebView()

		let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
		webview.load(request)

		return webview
	}

	func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
		let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
		webview.load(request)
	}
}
