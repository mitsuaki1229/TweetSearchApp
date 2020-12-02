//
//  TweetRowView.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/02.
//

import SwiftUI

struct TweetRowView: View {
    var tweet: Tweet
    var body: some View {

        HStack {
            URLImageView(viewModel: .init(url: tweet.user.profileImageUrl))
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
            Text(tweet.text).padding(10)
            Spacer()
            Text(tweet.user.name)
        }
        .padding(30)
    }
}
