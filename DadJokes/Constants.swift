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
    static let randomJokeQuery: String = "{\"query\": \"query { joke { joke } }\"}"
    static let searchJokeQuery: String = "{\"query\": \"query { joke (query: \\\"%@\\\") { joke } }\"}"
    
    static let searchInputTitle: String = "Search for a random joke"
    static let searchInputAccessibilityIdentifier = "txtSearch"
    static let searchInputPlaceholder: String = "e.g. elephant"
    static let searchButtonTitle: String = "Search"
}

enum Errors: String {
    case invalidResponse = "Invalid Response"
    case noResultsFound = "Want to hear a joke about construction while you wait? Nah, I'm still working on it. Please try again later or may be search for something else."
}

enum RandomJokeResponse: String {
    case data
    case joke
}

enum MessageType: String {
    case error = "Error"
    case unknown = "Something is not right!"
}

enum MessageActions: String {
    case ok = "Ok"
}

enum PersistanceKeys: String {
    case joke
}

enum Segues: String {
    case jokeSearch
}
