//
//  UIFontExtension.swift
//  Zues
//
//  Created by Do Duc on 20/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit

extension UIFont {
    class func openSansRegularFont(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans", size: fontSize)!
    }

    class func openSansItalicFont(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Italic", size: fontSize)!
    }

    class func appMediumFont(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: fontSize)!
    }

    class func appRegularFont(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: fontSize)!
    }

    class func appLightFont(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Light", size: fontSize)!
    }
}
