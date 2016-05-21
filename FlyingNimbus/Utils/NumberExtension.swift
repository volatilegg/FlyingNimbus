//
//  GKNumberExtension.swift
//  Zues
//
//  Created by Do Duc on 19/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit

let kelvinCoefficient: Float = 273.5

extension Float {
    func kelToCel() -> Float {
        return self - kelvinCoefficient
    }
}

//Help calculate the views' frame faster
extension CGSize {

    func screenSize() -> CGSize {
        return (UIScreen.mainScreen().bounds.size)
    }

    static func screenWidth() -> CGFloat {
        return (UIScreen.mainScreen().bounds.size.width)
    }

    static func screenHeight() -> CGFloat {
        return (UIScreen.mainScreen().bounds.size.height)
    }

    static func screenRatio() -> CGFloat {
        return (UIScreen.mainScreen().bounds.size.width/320)
    }
}
