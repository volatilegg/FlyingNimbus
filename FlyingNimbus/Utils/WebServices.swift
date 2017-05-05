//
//  WebServices.swift
//  Zues
//
//  Created by Do Duc on 19/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum NetworkError: Error {
    case badRequest(result: String)
}

class WebServices {
    //We only need one instance web service at once, so singleton all the way
    static let sharedInstance = WebServices()
    //private to prevent other classes using default initializer of this class
    fileprivate init() {
        print("init web service")
    }


    func fetchStationData() -> Promise<StationList> {
        return Promise { fulfill, reject in
            Alamofire.request("http://api.digitransit.fi/routing/v1/routers/hsl/bike_rental")                
                .validate()
                .responseData { (response) -> Void in
                do {
                    let res = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: AnyObject]
                    let listObject = StationList(json: res)
                    print(res)
                    fulfill(listObject!)
                } catch {
                    let res = String(data: response.data!, encoding: String.Encoding.utf8)
                    reject(NetworkError.badRequest(result: res!))
                }
            }
        }
    }

}
