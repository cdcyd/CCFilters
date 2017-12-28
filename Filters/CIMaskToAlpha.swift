//
//  CIMaskToAlpha.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIMaskToAlpha: BaseFilter {

    private let image = UIImage("ImageK")
    private let name = "CIMaskToAlpha"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIMaskToAlpha
        系统：iOS6.0
        简介：Converts a grayscale image to a white image that is masked by alpha.
        详情：The white values from the source image produce the inside of the mask; the black values become completely transparent.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [String: Any]())
        self.imageView2.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
