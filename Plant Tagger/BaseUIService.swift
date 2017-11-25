//
//  BaseUIService.swift
//  Plant Tagger
//
//  Created by Chun Yap on 17/10/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import UIKit

class BaseUIService: BaseAPI {

    var viewController: UIViewController
    
    init( viewController: UIViewController )
    {
        self.viewController = viewController
    }
    
    internal func _showErrorMessageBox(errorText: String)
    {
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        })
        
        self.viewController.present(alert, animated: true)
    }}
