//
//  CIDiscBlur.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/20.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIDiscBlur: BaseFilter {

    private let image = UIImage("ImageA")
    private let name = "CIDiscBlur"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "Radius", min: 0, max: 100, value: 8)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIDiscBlur(环形卷积模糊)
        系统：iOS9.0
        简介：Blurs an image using a disc-shaped convolution kernel.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [kCIInputRadiusKey: NSNumber(value: 8)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIDiscBlur: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputRadiusKey: NSNumber(value: value)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
