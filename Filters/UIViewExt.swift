//
//  UIViewExt.swift
//  Filters
//
//  Created by cyd on 2018/3/21.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

extension UIView {
    func viewController() -> UIViewController? {
        if let next = self.next as? UIViewController {
            return next
        }
        var view = self.superview
        while view != nil {
            guard let next = view?.next as? UIViewController else {
                view = view?.superview
                continue
            }
            return next
        }
        return nil
    }
}
