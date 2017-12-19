//
//  CINoiseReduction.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/21.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CINoiseReduction: BaseFilter {

    private let image = UIImage("ImageB")
    private let name = "CINoiseReduction"
    private var noiseLevel = NSNumber(value: 0.02)
    private var sharpness = NSNumber(value: 0.40)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "噪音等级", min: 0.0, max: 0.1, value: 0.02)
        slider.delegate = self
        slider.slider.tag = 100
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "锐        度", min: 0.0, max: 2.0, value: 0.40)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 300
        self.view.addSubview(slider1)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CINoiseReduction，图片降噪
        系统：iOS9.0
        简介：Reduces noise using a threshold value to define what is considered noise.
        详情：Small changes in luminance below that value are considered noise and get a noise reduction treatment, which is a local blur. Changes above the threshold value are considered edges, so they are sharpened.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [kCIInputSharpnessKey: sharpness, "inputNoiseLevel": noiseLevel])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CINoiseReduction: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            noiseLevel = NSNumber(value: slider.value)
        } else {
            sharpness = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputSharpnessKey: self.sharpness, "inputNoiseLevel": self.noiseLevel])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
