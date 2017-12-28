//
//  CIColorControls.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorControls: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIColorControls"
    private var saturation = NSNumber(value: 1.0)
    private var brightness = NSNumber(value: 0.0)
    private var contrast = NSNumber(value: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "saturatn", min: 0.0, max: 2.0, value: 1.0)
        slider.delegate = self
        slider.slider.tag = 100
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "brightne", min: -1.0, max: 1.0, value: 0.0)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 300
        self.view.addSubview(slider1)

        let slider2 = SliderView(title: "contrast", min: 0.0, max: 4, value: 1.0)
        slider2.delegate = self
        slider2.slider.tag = 102
        slider2.frame.origin.y = 350
        self.view.addSubview(slider2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorControls
        系统：iOS5.0
        简介：Adjusts saturation, brightness, and contrast values.
        详情：To calculate saturation, this filter linearly interpolates between a grayscale image (saturation = 0.0) and the original image (saturation = 1.0). The filter supports extrapolation: For values large than 1.0, it increases saturation.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputSaturation": saturation, "inputBrightness": brightness, "inputContrast": contrast])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorControls: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            saturation = NSNumber(value: slider.value)
        } else if slider.tag == 101 {
            brightness = NSNumber(value: slider.value)
        } else {
            contrast  = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputSaturation": self.saturation, "inputBrightness": self.brightness, "inputContrast": self.contrast])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
