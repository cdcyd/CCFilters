//
//  CIExposureAdjust.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIExposureAdjust: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIExposureAdjust"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "EV", min: -10, max: 10, value: 0.50)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIExposureAdjust
        系统：iOS5.0
        简介：Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.
        详情：This filter multiplies the color values, as follows, to simulate exposure change by the specified F-stops: s.rgb * pow(2.0, ev)
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputEV": NSNumber(value: 0.5)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIExposureAdjust: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputEV": NSNumber(value: value)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
