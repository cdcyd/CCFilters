//
//  CIStretchCrop.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIStretchCrop: BaseFilter {

    private let image = UIImage("ImageI")
    private let name = "CIStretchCrop"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIStretchCrop
        系统：iOS9.0
        简介：Distorts an image by stretching and or cropping it to fit a target size.
        """
    }

    private func setupImages() {
        let size = self.imageView2.frame.size
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputSize": CIVector(x: size.width, y: size.height),
                                                                      "inputCenterStretchAmount": NSNumber(value: 0.0),
                                                                      "inputCropAmount": NSNumber(value: 50.0)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
