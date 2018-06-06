//
//  RandomJokeVC.swift
//  DadJokes
//
//  Created by Tulakshana Weerasooriya on 2018-06-02.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import UIKit

class RandomJokeVC: UIViewController {
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var jokeTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var searchTerm: String?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.jokeSearch.rawValue {
            if let vc = segue.destination as? RandomJokeSearchVC {
                vc.searchTerm = self.searchTerm
            }
        }
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
                self.save(joke: aRandomJoke)
                self.fetchRandomJoke()
            } else {
                self.save(joke: aRandomJoke)
            }
        }
    }
    
    func save(joke: String?) {
        UserDefaults.standard.set(joke, forKey: PersistanceKeys.joke.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func btnNextTapped (button: UIButton) {
        self.fetchRandomJoke()
    }
    
    @IBAction func btnSearchTapped (button: UIBarButtonItem) {
        let alert = UIAlertController(title: Constants.searchInputTitle, message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: Constants.searchButtonTitle, style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.searchTerm = textField.text
            self.performSegue(withIdentifier: Segues.jokeSearch.rawValue, sender: button)
        }
        alert.addTextField { (textField) in
            textField.placeholder = Constants.searchInputPlaceholder
            textField.accessibilityIdentifier = Constants.searchInputAccessibilityIdentifier
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
