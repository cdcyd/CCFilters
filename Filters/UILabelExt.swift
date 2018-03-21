//
//  UILabelExt.swift
//  Filters
//
//  Created by cyd on 2018/3/21.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.font = UIFont.systemFont(ofSize: 14)
        self.text = text
        self.sizeToFit()
    }
}
