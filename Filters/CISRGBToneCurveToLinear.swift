//
//  CISRGBToneCurveToLinear.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CISRGBToneCurveToLinear: BaseFilter {

    private let image = UIImage("ImageG")
    private let name = "CISRGBToneCurveToLinear"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CISRGBToneCurveToLinear
        系统：iOS7.0
        简介：Maps color intensity from the sRGB color space to a linear gamma curve.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [String: Any]())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
