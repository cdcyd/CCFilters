//
//  CIGaussianBlur.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/20.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIGaussianBlur: BaseFilter {

    private let image = UIImage("ImageA")
    private let name = "CIGaussianBlur"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSliderViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupSliderViews() {
        let slider = SliderView(title: "模糊度", min: 0, max: 100, value: 10)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = "滤镜：CIGaussianBlur(高斯模糊)\n系统：iOS6.0\n参数：kCIInputRadiusKey，默认10.0，最小0.0，最大100.0"
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [kCIInputRadiusKey: NSNumber(value: 10)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIGaussianBlur: SliderViewDelegate {
    func valueChanged(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputRadiusKey: NSNumber(value: value)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
