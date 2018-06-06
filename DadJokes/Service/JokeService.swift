//
//  JokeService.swift
//  DadJokes
//
//  Created by Tulakshana Weerasooriya on 2018-05-31.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import Foundation

struct JokeService {
    
    static func fetchRandomJoke(completionHandler: @escaping (_ aRandomJoke: String?, _ errorMsg: String?) -> Void) {
        JokeService.fetchRandomJoke(searchTerm: nil) { (joke: String?, eMsg: String?) in
            completionHandler(joke, eMsg)
        }
    }
    
    static func fetchRandomJoke(searchTerm: String?, completionHandler: @escaping (_ aRandomJoke: String?, _ errorMsg: String?) -> Void) {
        let url = URL(string: Constants.apiURL)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        var postString = ""
        if searchTerm == nil {
            postString = Constants.randomJokeQuery
        } else {
            postString = String(format: Constants.searchJokeQuery, searchTerm!)
        }
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, error?.localizedDescription)
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                DispatchQueue.main.async {
                    completionHandler(nil, Errors.invalidResponse.rawValue)
                }
                return
            }
            
            if let dataDic = self.dictionaryFromJSON(jsonData: data)?[RandomJokeResponse.data.rawValue] as? [String: Any] {
                if let jokeDic = dataDic[RandomJokeResponse.joke.rawValue] as? [String: Any],
                    let joke = jokeDic[RandomJokeResponse.joke.rawValue] as? String {
                    DispatchQueue.main.async {
                        completionHandler(joke, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(nil, Errors.noResultsFound.rawValue)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(nil, Errors.invalidResponse.rawValue)
                }
            }
        }
        task.resume()
    }
    
    private static func dictionaryFromJSON(jsonData: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
