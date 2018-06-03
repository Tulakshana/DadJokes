//
//  ViewController.swift
//  DadJokes
//
//  Created by Tulakshana Weerasooriya on 2018-05-31.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var jokeTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchRandomJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    
    func fetchRandomJoke() {
        jokeTextView.text = UserDefaults.standard.value(forKey: PersistanceKeys.joke.rawValue) as? String
        btnNext.isEnabled = false
        activityIndicator.startAnimating()
        JokeService.fetchRandomJoke { (aRandomJoke: String?, errorMsg: String?) in
            self.activityIndicator.stopAnimating()
            self.btnNext.isEnabled = true
            guard errorMsg == nil else {
                self.showMessage(type: .error, text: errorMsg)
                return
            }
            if UserDefaults.standard.value(forKey: PersistanceKeys.joke.rawValue) == nil {
                self.jokeTextView.text = aRandomJoke
            }
            UserDefaults.standard.set(aRandomJoke, forKey: PersistanceKeys.joke.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func btnNextTapped (button: UIButton) {
        self.fetchRandomJoke()
    }
}

