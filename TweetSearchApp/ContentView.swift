//
//  ContentView.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/02.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = SearchModel()

    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
            TimelineView(tweets: viewModel.tweets, maxId: $viewModel.maxId)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
