//
//  UserService.swift
//  Plant Tagger
//
//  Created by Chun Yap on 11/11/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserService: BaseAPI {
    
    override var includeToken: Bool { return true }
    
    struct User {
        let id: String
        let name: String
        let email: String
    }
    
    func getProfile(onSuccessCallback: ((_ response: User) -> Void)?,
                    onFailureCallback: ((_ error: String) -> Void)? = nil)
    {
        self._callGetProfileAPI(onSuccessCallback: { response in            
                                    let user = User(
                                        id: response["uuid"].string!,
                                        name: response["name"].string!,
                                        email: response["email"].string!)
                                    onSuccessCallback!(user)
                                },
                                onFailureCallback: onFailureCallback)
    }
    
    func getProfileImage(onSuccessCallback: ((_ response: User) -> Void)?,
                         onFailureCallback: ((_ error: String) -> Void)? = nil)
    {
        self._callGetProfileAPI(onSuccessCallback: { response in
            let user = User(
                id: response["uuid"].string!,
                name: response["name"].string!,
                email: response["email"].string!)
            onSuccessCallback!(user)
        },
                                onFailureCallback: onFailureCallback)
    }
    
    private func _callGetProfileAPI( onSuccessCallback: ((_ response: JSON) -> Void)?,
                                     onFailureCallback: ((_ error: String) -> Void)?)
    {
        self.getRequest(uri: "user",
                        onSuccessCallback: onSuccessCallback,
                        onFailureCallback: onFailureCallback)
    }
}
