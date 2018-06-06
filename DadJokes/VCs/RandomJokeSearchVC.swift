//
//  RandomJokeSearchVC.swift
//  DadJokes
//
//  Created by Tulakshana Weerasooriya on 2018-06-04.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import UIKit

class RandomJokeSearchVC: RandomJokeVC {
    
    var nextJoke: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.searchTerm
    }
    
    override func fetchRandomJoke() {
        jokeTextView.text = self.nextJoke
        btnNext.isEnabled = false
        activityIndicator.startAnimating()
        JokeService.fetchRandomJoke(searchTerm: self.searchTerm) { (aRandomJoke: String?, errorMsg: String?) in
            self.activityIndicator.stopAnimating()
            self.btnNext.isEnabled = true
            guard errorMsg == nil else {
                self.showMessage(type: .unknown, text: errorMsg)
                return
            }
            if self.nextJoke == nil {
                self.jokeTextView.text = aRandomJoke
                self.nextJoke = aRandomJoke
                self.fetchRandomJoke()
            } else {
                self.nextJoke = aRandomJoke
            }
        }
    }
}
