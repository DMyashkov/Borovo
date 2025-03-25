//
//  PNNetworking.swift
//  pirin
//
//  Created by Ivan Ugrin on W21/05/20/19.
//  Copyright © 2019 Donatix. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Networking: NSObject {
    public static let shared = Networking()
    fileprivate static let HEADER_FIELDS = ["Accept": "application/json"]
    fileprivate static let BASE_URL = "http://87.121.46.231:1112/geoserver/bsborovo/ows?service=WFS&version=2.0.0&request=GetFeature&outputFormat=application/json&typeName=bsborovo:blackspot:"
    private static let ENCODING = URLEncoding.httpBody
    private static let QUEUE = DispatchQueue.main
    
    fileprivate let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HEADER_FIELDS
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    func blackspots(completion: @escaping (_ result: JSON?) -> Void) {
        sessionManager.request((Networking.BASE_URL + "blackspots"), method: .get, parameters: nil, encoding: Networking.ENCODING)
            .validate()
            .responseJSON(completionHandler: { (response) in
                if response.result.isSuccess {
                    do {
                        if  let data = response.data {
                            completion(try JSON(data: data))
                            return
                        }
                    }
                    catch {
                        print("Error info: \(error)")
                    }
                }
                
                completion(nil)
            })
    }
    
    func accidents(completion: @escaping (_ result: JSON?) -> Void) {
        sessionManager.request((Networking.BASE_URL + "accidents"), method: .get, parameters: nil, encoding: Networking.ENCODING)
            .validate()
            .responseJSON(completionHandler: { (response) in
                if response.result.isSuccess {
                    do {
                        if  let data = response.data {
                            completion(try JSON(data: data))
                            return
                        }
                    }
                    catch {
                        print("Error info: \(error)")
                    }
                }
                
                completion(nil)
            })
    }
}
