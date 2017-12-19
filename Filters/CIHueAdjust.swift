//
//  CIHueAdjust.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIHueAdjust: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIHueAdjust"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "Angle", min: -Float.pi, max: Float.pi, value: 0.0)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIHueAdjust
        系统：iOS5.0
        简介：Changes the overall hue, or tint, of the source pixels.
        详情：This filter essentially rotates the color cube around the neutral axis.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputAngle": NSNumber(value: 0.0)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIHueAdjust: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputAngle": NSNumber(value: value)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
