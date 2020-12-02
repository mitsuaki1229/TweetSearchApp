//
//  Tweet.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/02.
//

import Foundation

struct Tweet: Codable, Identifiable {
    
    var id: Int
    var text: String
    var user: User
}
