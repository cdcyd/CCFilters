//
//  CIZoomBlur.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/21.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIZoomBlur: BaseFilter {

    private let image = UIImage("ImageC")
    private let name = "CIZoomBlur"
    private var centerX = CGFloat(150.0)
    private var centerY = CGFloat(150.0)
    private var amount = NSNumber(value: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSliderViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupSliderViews() {
        let slider = SliderView(title: "centerX", min: 0.0, max: 300.0, value: 150.0)
        slider.delegate = self
        slider.slider.tag = 100
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "centerY", min: 0.0, max: 300.0, value: 150.0)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 300
        self.view.addSubview(slider1)

        let slider2 = SliderView(title: "模 糊 度", min: -200, max: 200, value: 20.0)
        slider2.delegate = self
        slider2.slider.tag = 102
        slider2.frame.origin.y = 350
        self.view.addSubview(slider2)
    }

    private func setupDescription() {
        self.descView.text = "滤镜：CIZoomBlur(变焦模糊)\n系统：iOS8.3\n参数：kCIInputCenterKey，默认{150,150}\n           inputAmount，默认20.0，最小-200，最大200"
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [kCIInputCenterKey: CIVector(x: centerX, y: centerY), "inputAmount": amount])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIZoomBlur: SliderViewDelegate {
    func valueChanged(slider: UISlider) {
        if slider.tag == 100 {
            centerX = CGFloat(slider.value)
        } else if slider.tag == 101 {
            centerY = CGFloat(slider.value)
        } else {
            amount  = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputCenterKey: CIVector(x: self.centerX, y: self.centerY), "inputAmount": self.amount])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
