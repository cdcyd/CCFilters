//
//  CIBumpDistortionLinear.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIBumpDistortionLinear: BaseFilter {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.descView.frame.origin.y = 50
        self.descView.textAlignment = .center
        self.descView.text = "该滤镜只有 OS X v10.5 and later 才可以用，iOS不能用"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
}
