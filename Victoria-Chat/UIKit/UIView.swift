//
//  UIView.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/5/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import UIKit

extension UIView {
    
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

