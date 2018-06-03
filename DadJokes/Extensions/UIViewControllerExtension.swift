//
//  UIViewControllerExtension.swift
//  DadJokes
//
//  Created by Tulakshana Weerasooriya on 2018-06-02.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessage(type: MessageType, text: String?) {
        let ac: UIAlertController = UIAlertController.init(title: type.rawValue, message: text, preferredStyle: .alert)
        ac.addAction(UIAlertAction.init(title: MessageActions.ok.rawValue, style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}
