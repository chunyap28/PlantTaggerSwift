//
//  BaseUIViewController.swift
//  Plant Tagger
//
//  Created by Chun Yap on 18/10/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    var isAlertPresented:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func _showErrorMessageBox(errorText: String)
    {
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        })
     
        self._showAlert(alertController: alert)
    }
    
    internal func _showLoading( message: String = "Please wait...")
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self._showAlert(alertController: alert)
    }

    internal func _showAlert( alertController: UIAlertController )
    {
        if( self.isAlertPresented ){//dismiss and show
            debugPrint("dismiss and show")
            self.dismiss(animated: false, completion: { Void in
                // On completion of the dismiss, we present another
                self.isAlertPresented = false
                self.present(alertController, animated: true)
            })
        }
        else{//show
            debugPrint("just show")
            self.present(alertController, animated: true)
        }
        self.isAlertPresented = true
    }
    
    internal func _hideLoading()
    {
        self.dismiss(animated: false, completion: { Void in
            // On completion of the dismiss, we present another
            self.isAlertPresented = false
        })
    }
}
