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

class SignUpViewController: BaseUIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate
{
    
    @IBOutlet weak var emailSignUpButton: UIButton!
    @IBOutlet weak var fbSignUpButton: FBSDKLoginButton!
    @IBOutlet weak var gSignUpButton: GIDSignInButton!
    
    @IBOutlet weak var nameTextField: DesignableUITextField!
    @IBOutlet weak var emailTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        //loginButton.center = view.center
        
        //view.addSubview(loginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        self.fbSignUpButton.delegate = self
        
        let buttonText = NSAttributedString(string: "Continue with Facebook")
        fbSignUpButton.setAttributedTitle(buttonText, for: .normal)
        fbSignUpButton.loginBehavior = FBSDKLoginBehavior.web
        
        gSignUpButton.style = GIDSignInButtonStyle.wide
    }
    
    @IBAction func onSignUpRequested(_ sender: Any) {
        print("sign up pressed")
        self._showLoading(message: "Signing up...")
        let api = RegistrationService()
        api.register(name: self.nameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!,
                     onSuccessCallback: { json in
                        self._hideLoading()
                        self._loginAndProceed(email: self.emailTextField.text!, password: self.passwordTextField.text!)},
                     onFailureCallback: { errorText in
                        self._showErrorMessageBox(errorText: errorText)
                    })
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        self._showLoading(message: "Signing up...")
        if( result.isCancelled )
        {
            print("Cancelled")
        }
        else
        {
            let api = RegistrationService()
            api.register(token: result.token.tokenString,
                         onSuccessCallback: { json in
                            self._hideLoading()
                            self._loginAndProceed(token: result.token.tokenString)},
                         onFailureCallback: { errorText in
                            self._showErrorMessageBox(errorText: errorText)
            })
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        print("Logged Out")
    }
    
    private func _loginAndProceed(email: String, password: String)
    {
        let authServ = AuthenticationService()
        authServ.login(email: email, password: password,
                       onSuccessCallback: { json in
                        self._moveToLoggedInPage()},
                       onFailureCallback: { errorText in
                        self._showErrorMessageBox(errorText: errorText)
        })
    }
    
    private func _loginAndProceed(token: String)
    {
        let authServ = AuthenticationService()
        authServ.login(token: token,
                       onSuccessCallback: { json in
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

