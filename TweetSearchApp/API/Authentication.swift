//
//  Authentication.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/02.
//

import Foundation

struct Authentication {
    
    func getBearerToken(consumerKey: String, consumerSecret: String,
                        success: @escaping (String) -> Void,
                        failure: @escaping (String) -> Void) {

        var compnents = URLComponents(string: "https://api.twitter.com/oauth2/token")
        compnents?.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]

        var request = URLRequest(url: (compnents?.url)!)
        request.httpMethod = "POST"

        guard let credentialData = "\(consumerKey):\(consumerSecret)".data(using: String.Encoding.utf8) else { return }
        let credential = credentialData.base64EncodedString(options: [])
        let basicData = "Basic \(credential)"

        request.setValue(basicData, forHTTPHeaderField: "Authorization")

        let task: URLSessionTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
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

                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let token: Token = try jsonDecoder.decode(Token.self, from: data!)
                        success(token.accessToken)
                    } catch {
                        failure(error.localizedDescription)
                    }
                })
                task.resume()
    }
}
