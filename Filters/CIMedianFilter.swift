//
//  CIMedianFilter.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/21.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIMedianFilter: BaseFilter {

    private let image = UIImage("ImageB")
    private let name = "CIMedianFilter"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIMedianFilter(中值模糊)，用于消除图像噪点
        系统：iOS9.0
        简介：Computes the median value for a group of neighboring pixels and replaces each pixel value with the median.
        详情：The effect is to reduce noise.
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
