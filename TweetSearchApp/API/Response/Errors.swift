//
//  Errors.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/06.
//

import Foundation

struct Errors: Codable {
    var errors: [Error]
}

struct Error: Codable {
    var code: Int
    var label: String?
    var message: String
}
