//
//  AuthenticationAPI.swift
//  Plant Tagger
//
//  Created by Chun Yap on 8/10/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SimpleKeychain

class AuthenticationService: BaseAPI {
            
    func login( email: String, password: String,
        onSuccessCallback: ((_ response: JSON) -> Void)?,
        onFailureCallback: ((_ error: String) -> Void)?)
    {
        let email = email
        let password = password
        
        let parameters = ["userID": email, "password": password, "type": "PASSWORD"] as Dictionary<String, String>
        self._callLoginAPI(parameters: parameters, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
    }
    
    func login( token: String,
                onSuccessCallback: ((_ response: JSON) -> Void)?,
                onFailureCallback: ((_ error: String) -> Void)? )
    {
        let token = token
        
        let parameters = ["token": token, "type": "FACEBOOK"] as Dictionary<String, String>
        self._callLoginAPI(parameters: parameters, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
    }
    
    func logout()
    {
        //todo call API
        
        A0SimpleKeychain().deleteEntry(forKey: "auth0-user-jwt")
    }
    
    private func _callLoginAPI( parameters: Dictionary<String, String>,
                                onSuccessCallback: ((_ response: JSON) -> Void)?,
                                onFailureCallback: ((_ error: String) -> Void)?)
    {
        self.postRequest(uri: "auth", parameters: parameters, onSuccessCallback: { response in
            self._saveToken(json: response)
            onSuccessCallback!(response)
        }, onFailureCallback: onFailureCallback)
    }
    
    private func _saveToken( json: JSON)
    {
        let jwt = json["token"].string!
        A0SimpleKeychain().setString(jwt, forKey:"auth0-user-jwt")
    }
    
    /*
    private func onSucess()
    {
        self._moveToLoggedInPage()
    }
    
    private func onError( errorText: String)
    {
        self._showErrorMessageBox(errorText: errorText)
    }        
    
    private func _moveToLoggedInPage()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ptTabBar = storyboard.instantiateViewController(withIdentifier: "ptTabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = ptTabBar
    }*/
}
