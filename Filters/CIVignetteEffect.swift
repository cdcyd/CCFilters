//
//  CIVignetteEffect.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIVignetteEffect: BaseFilter {

    private let image = UIImage("ImageM")
    private let name = "CIVignetteEffect"
    private var inten = NSNumber(value: 1.0)
    private var radius = NSNumber(value: 150.0)
    private var fall = NSNumber(value: 0.5)
    private var center = CIVector(x: 150.0, y: 150.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let redius = SliderView(title: "redius", min: 0.0, max: 2000.0, value: 150.0)
        redius.delegate = self
        redius.tag = 100
        self.view.addSubview(redius)

        let slider1 = SliderView(title: "Inten  ", min: -1.0, max: 1.0, value: 1.0)
        slider1.delegate = self
        slider1.tag = 101
        slider1.frame.origin.y = 290
        self.view.addSubview(slider1)

        let slider2 = SliderView(title: "fall      ", min: 0.0, max: 1.0, value: 0.5)
        slider2.delegate = self
        slider2.tag = 102
        slider2.frame.origin.y = 330
        self.view.addSubview(slider2)

        let center = PointView(title: "center", X: 150, Y: 150)
        center.frame.origin.y = 370
        center.delegate = self
        self.view.addSubview(center)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIVignetteEffect
        系统：iOS7.0
        简介：Reduces the brightness of an image at the periphery.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRadius": radius,
                                                                      "inputIntensity": inten,
                                                                      "inputFalloff": fall,
                                                                      "inputCenter": center])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIVignetteEffect: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        center = point
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius,
                                                                         "inputIntensity": self.inten,
                                                                         "inputFalloff": self.fall,
                                                                         "inputCenter": self.center])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}

extension CIVignetteEffect: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        slider.tag == 100 ? (radius = NSNumber(value: slider.value)) :
        slider.tag == 101 ? (inten = NSNumber(value: slider.value)) : (fall = NSNumber(value: slider.value))
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius,
                                                                         "inputIntensity": self.inten,
                                                                         "inputFalloff": self.fall,
                                                                         "inputCenter": self.center])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
