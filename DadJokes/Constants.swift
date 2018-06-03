//
//  Constants.swift
//  DadJokes
//
//  Created by Tulakshana Weerasooriya on 2018-05-31.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import Foundation

struct Constants {
    static let apiURL: String = "https://icanhazdadjoke.com/graphql"
    static let randomJokeQuery: String = "{\"query\": \"query { joke {id joke permalink } }\"}"
}

enum Errors: String {
    case invalidResponse = "Invalid Response"
}

enum RandomJokeResponse: String {
    case data
    case joke
}

enum MessageType: String {
    case error = "Error"
}

enum MessageActions: String {
    case ok = "Ok"
}

enum PersistanceKeys: String {
    case joke
}
