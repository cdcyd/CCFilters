//
//  CIPhotoEffectMono.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIPhotoEffectMono: BaseFilter {

    private let image = UIImage("ImageL")
    private let name = "CIPhotoEffectMono"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIPhotoEffectMono
        系统：iOS7.0
        简介：Applies a preconfigured set of effects that imitate vintage photography film with distorted colors.
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
