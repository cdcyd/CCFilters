//
//  CIColorMap.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorMap: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIColorMap"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorMap
        系统：iOS6.0
        简介：Performs a nonlinear transformation of source color values using mapping values provided in a table.
        """
    }

    private func setupImages() {
        let gradient = UIImage("ImageI")
        let ci = CIImage(cgImage: gradient.cgImage!)
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputGradientImage": ci])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
