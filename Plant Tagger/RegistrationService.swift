//
//  PlantTaggerAPI.swift
//  Plant Tagger
//
//  Created by Chun Yap on 9/9/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegistrationService: BaseAPI {
    
    func register( name: String, email: String, password: String,
                   onSuccessCallback: ((_ response: JSON) -> Void)?,
                   onFailureCallback: ((_ error: String) -> Void)?)
    {
        let parameters = ["name": name, "email": email, "password": password, "type": "PASSWORD"] as Dictionary<String, String>
        self._callAPI( parameters: parameters, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
    }
    
    func register( token: String,
                   onSuccessCallback: ((_ response: JSON) -> Void)?,
                   onFailureCallback: ((_ error: String) -> Void)?)
    {
        let parameters = ["token": token, "type": "FACEBOOK"] as Dictionary<String, String>
        self._callAPI( parameters: parameters, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
    }
    
    private func _callAPI( parameters: Dictionary<String, String>,
                           onSuccessCallback: ((_ response: JSON) -> Void)?,
                           onFailureCallback: ((_ error: String) -> Void)?)
    {
        self.postRequest(uri: "user", parameters: parameters, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
    }
}
