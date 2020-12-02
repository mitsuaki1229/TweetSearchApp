//
//  Search.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/02.
//

import Foundation

struct Search {

    func getTimeline(accessToken: String, searchText: String, maxId: Int?,
                     success: @escaping ([Tweet]) -> Void,
                     failure: @escaping (String) -> Void) {

        var compnents = URLComponents(string: "https://api.twitter.com/1.1/search/tweets.json")

        var queryItems = [URLQueryItem(name: "q", value: searchText),
                          URLQueryItem(name: "count", value: "20")]

        if let maxId = maxId {
            queryItems.append(URLQueryItem(name: "max_id", value: String(maxId)))
        }

        compnents?.queryItems = queryItems

        var request = URLRequest(url: (compnents?.url)!)
        request.httpMethod = "GET"

        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let task: URLSessionTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                    do {

                        if let error = error {
                            failure(error.localizedDescription)
                            return
                        }

                        if let response = response as? HTTPURLResponse {
                            if response.statusCode != 200 {
                                let jsonDecoder = JSONDecoder()
                                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                                let errors: Errors = try jsonDecoder.decode(Errors.self, from: data!)
                                failure(errors.errors.first!.message)
                                return
                            }
                        }

                        let json = try JSONSerialization
                            .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let statuses = json?["statuses"]
                        let statusesData = try JSONSerialization.data(withJSONObject: statuses as Any)
                        let tweets: [Tweet] = try jsonDecoder.decode([Tweet].self, from: statusesData)
                        success(tweets)
                    } catch {
                        failure(error.localizedDescription)
                    }
                })
                task.resume()
    }
}
