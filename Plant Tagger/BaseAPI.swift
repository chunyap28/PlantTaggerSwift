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
import SimpleKeychain

class BaseAPI {
    
    var basedUrl = "http://localhost:8080/"
    var includeToken: Bool { return false }
    
    public func postRequest( uri: String, parameters: Dictionary<String, String>,
                             headers: Dictionary<String, String>? = nil,
                             onSuccessCallback: ((_ response: JSON) -> Void)?,
                             onFailureCallback: ((_ error: String) -> Void)?)
    {
        guard !uri.isEmpty else {
            return
        }
        
        var sHeader = self._getStandardHeader();
        if( headers != nil ){
            sHeader.update(other: headers!)}
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters
                {
                    multipartFormData.append(value.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                }
        },
            to: basedUrl + uri,
            headers: sHeader,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        self.onSuccess(response: response, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
                    }
                case .failure(let encodingError):
                    onFailureCallback!(encodingError.localizedDescription)
                }
        }
        )
    }
    
    public func getRequest( uri: String, parameters: Dictionary<String, String>? = nil,
                            headers: Dictionary<String, String>? = nil,
                             onSuccessCallback: ((_ response: JSON) -> Void)?,
                             onFailureCallback: ((_ error: String) -> Void)?)
    {
        guard !uri.isEmpty else {
            return
        }
        
        var sHeader = self._getStandardHeader();
        if( headers != nil ){
            sHeader.update(other: headers!)}
        
        Alamofire.request(basedUrl + uri,
                          parameters: parameters,
                          headers: sHeader)
                 .responseJSON { response in
                    debugPrint(response)
                    self.onSuccess(response: response, onSuccessCallback: onSuccessCallback, onFailureCallback: onFailureCallback)
                }
    }
    
    private func onSuccess( response: DataResponse<Any>,
                            onSuccessCallback: ((_ json: JSON) -> Void)?,
                            onFailureCallback: ((_ error: String) -> Void)?)
    {
        switch response.result {
        case .success(let data):
            let json = JSON(data)
            
            if (response.response?.statusCode != 200){
                
                var errMsg = "Something is wrong. Please try again later"
                if( json.dictionaryObject?.keys.contains("message") )!{
                    errMsg = json["message"].string!
                }
                
                onFailureCallback?(errMsg)
            }
            else{
                onSuccessCallback?(json)
            }
            
        case .failure(let error):
            onFailureCallback?(error.localizedDescription)
        }
    }
    
    func getToken() -> String?
    {
        let jwt = A0SimpleKeychain().string(forKey: "auth0-user-jwt")
        return jwt
    }
    
    private func _getStandardHeader() -> Dictionary<String, String>
    {
        var headers = [:] as Dictionary<String, String>
        
        let jwt = self.getToken()
        if( jwt != nil )
        {
            headers["Authorization"] = jwt
        }
        
        return headers
    }
}
