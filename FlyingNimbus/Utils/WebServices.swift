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

enum NetworkError: ErrorType {
    case BadRequest(result: String)
}

class WebServices {
    //We only need one instance web service at once, so singleton all the way
    static let sharedInstance = WebServices()
    //private to prevent other classes using default initializer of this class
    private init() {
        print("init web service")
    }


    func fetchStationData() -> Promise<StationList> {
        return Promise { fulfill, reject in
            Alamofire.request(.GET, "http://api.digitransit.fi/routing/v1/routers/hsl/bike_rental")
                .validate()
                .responseData { (response) -> Void in
                do {
                    let res = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments) as! [String: AnyObject]
                    let listObject = StationList(json: res)
                    fulfill(listObject!)
                } catch {
                    let res = String(data: response.data!, encoding: NSUTF8StringEncoding)
                    reject(NetworkError.BadRequest(result: res!))
                }
            }
        }
    }

}
