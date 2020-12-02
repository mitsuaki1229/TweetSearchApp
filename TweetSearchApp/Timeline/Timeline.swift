//
//  Timeline.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/03.
//

import SwiftUI

struct TimelineView: View {

    var tweets: [Tweet]

    var body: some View {
        List(tweets) { tweet in
            TweetRowView(tweet: tweet)
        }
    }
}
