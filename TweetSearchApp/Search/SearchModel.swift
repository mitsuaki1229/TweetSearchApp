//
//  SearchModel.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/03.
//

import Foundation

final class SearchModel: ObservableObject {
    @Published var tweets: [Tweet] = []

    var searchText = "" {
        didSet {
            self.searchTweets()
        }
    }

    var maxId = 0 {
        didSet {
            self.searchTweets()
        }
    }

    func searchTweets() {
        Authentication().getBearerToken(consumerKey: "", consumerSecret: "") { [weak self] accessToken in
            print("SearchModel:", accessToken)
            print("SearchModel:", self!.searchText)
            Search().getTimeline(accessToken: accessToken, searchText: self!.searchText, maxId: self?.maxId) { [weak self] tweets in

                DispatchQueue.main.sync {
                    self?.tweets = tweets
                }
            } failure: { message in
                print("Search error:", message)
            }
        } failure: { message in
            print("Authentication error:", message)
        }
    }
}
