//
//  ViewController.swift
//  Plant Tagger
//
//  Created by Chun Yap on 27/5/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import UIKit
import FacebookLogin
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: BaseUIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
        
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var gLoginButton: GIDSignInButton!
    
    @IBOutlet weak var emailText: DesignableUITextField!
    @IBOutlet weak var passwordText: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        //loginButton.center = view.center
        
        //view.addSubview(loginButton)
                
        GIDSignIn.sharedInstance().uiDelegate = self
        self.fbLoginButton.delegate = self
    
        let buttonText = NSAttributedString(string: "Continue with Facebook")
        fbLoginButton.setAttributedTitle(buttonText, for: .normal)
        fbLoginButton.loginBehavior = FBSDKLoginBehavior.web
        gLoginButton.style = GIDSignInButtonStyle.wide
        
        //let GIDButton = GIDSignInButton()
        //GIDButton.center = view.center
        //view.addSubview(GIDButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        _showLoading(message: "Logging in...")
        if( result.isCancelled )
        {
            print("Cancelled")
        }
        else
        {
            print("Logged In")
            
            let authServ = AuthenticationService()
            authServ.login(token: result.token.tokenString,
                           onSuccessCallback: { json in
                            self._moveToLoggedInPage()},
                           onFailureCallback: { errorText in
                            self._showErrorMessageBox(errorText: errorText)
            })            
        }
        _hideLoading()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        print("Logged Out")
    }
    
    @IBAction func onSignInRequested(_ sender: Any)
    {
        _showLoading(message: "Logging in...")
        let authServ = AuthenticationService()
        authServ.login(email: self.emailText.text!, password: self.passwordText.text!,
                       onSuccessCallback: { json in
                        self._hideLoading()
                        self._moveToLoggedInPage()},
                       onFailureCallback: { errorText in
                        self._showErrorMessageBox(errorText: errorText)
        })
    }
    
    private func _moveToLoggedInPage()
    {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ptTabBar = self.storyboard?.instantiateViewController(withIdentifier: "ptTabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = ptTabBar
    }
}
