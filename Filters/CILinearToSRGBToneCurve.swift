//
//  CILinearToSRGBToneCurve.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CILinearToSRGBToneCurve: BaseFilter {

    private let image = UIImage("ImageG")
    private let name = "CILinearToSRGBToneCurve"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CILinearToSRGBToneCurve
        系统：iOS7.0
        简介：Maps color intensity from a linear gamma curve to the sRGB color space.
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
