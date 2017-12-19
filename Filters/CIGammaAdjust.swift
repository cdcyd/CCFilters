//
//  CIGammaAdjust.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIGammaAdjust: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIGammaAdjust"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "PW", min: 0.25, max: 4, value: 1.0)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIGammaAdjust
        系统：iOS5.0
        简介：Adjusts midtone brightness.
        详情：This filter is typically used to compensate for nonlinear effects of displays. Adjusting the gamma effectively changes the slope of the transition between black and white. It uses the following formula:
        pow(s.rgb, vec3(power))
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputPower": NSNumber(value: 1.0)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIGammaAdjust: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputPower": NSNumber(value: value)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
