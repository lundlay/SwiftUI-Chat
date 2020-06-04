//
//  UIColor.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/3/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(_ hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        
        return nil
    }
}

extension UIColor {
    
    class var bubbleShadow: UIColor {
        return UIColor("#000000FF") ?? UIColor.systemRed
    }

    class var bubbleBackground: UIColor {
        return UIColor("#FDFDFEFF") ?? UIColor.systemRed
    }

    class var viewBackground: UIColor {
        return UIColor("#F9FAFBFF") ?? UIColor.systemRed
    }

}

