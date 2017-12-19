//
//  CIMotionBlur.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/21.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIMotionBlur: BaseFilter {

    private let image = UIImage("ImageC")
    private let name = "CIMotionBlur"
    private var radius = NSNumber(value: 20.0)
    private var angles = NSNumber(value: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "模糊度", min: 0, max: 100, value: 20)
        slider.delegate = self
        slider.slider.tag = 100
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "角    度", min: -Float.pi, max: Float.pi, value: 0.0)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 300
        self.view.addSubview(slider1)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIMotionBlur(运动模糊)，用于模拟相机移动拍摄时的扫尾效果
        系统：iOS8.3
        简介：Blurs an image to simulate the effect of using a camera that moves a specified angle and distance while capturing the image.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [kCIInputRadiusKey: radius, kCIInputAngleKey: angles])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIMotionBlur: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            radius = NSNumber(value: slider.value)
        } else {
            angles = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputRadiusKey: self.radius, kCIInputAngleKey: self.angles])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
