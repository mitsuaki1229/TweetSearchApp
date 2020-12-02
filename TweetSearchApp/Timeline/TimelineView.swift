//
//  TimelineView.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/03.
//

import SwiftUI

struct TimelineView: View {

    var tweets: [Tweet]
    @Binding var maxId: Int

    var body: some View {
        List(tweets) { tweet in
            TweetRowView(tweet: tweet).onAppear {
                if tweets.isLastItem(tweet) {
                    print("Last tweet appear: ", tweet.id)
                    self.maxId = tweet.id
                }
            }
        }
    }
}
