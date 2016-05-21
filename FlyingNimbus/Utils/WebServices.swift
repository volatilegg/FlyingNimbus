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

    //Using PromiseKit to guarantee that the respond object will return in the weather form,
    //otherwise will cause error

}
