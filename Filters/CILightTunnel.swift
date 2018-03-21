//
//  CILightTunnel.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CILightTunnel: BaseFilter {

    private let image = UIImage("ImageT")
    private let name = "CILightTunnel"
    private var radius = NSNumber(value: 100.0)
    private var rotation = NSNumber(value: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "Radius", min: 1, max: 500, value: 300)
        slider.delegate = self
        slider.slider.tag = 100
        slider.frame.origin.y = 320
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "Rotation", min: 0.0, max: 1.570796326794897, value: 0.0)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 360
        self.view.addSubview(slider1)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CILightTunnel
        系统：iOS6.0
        简介：Rotates a portion of the input image specified by the center and radius parameters to give a tunneling effect.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRadius": radius,
                                                                      "inputRotation": rotation,
                                                                      "inputCenter": CIVector(x: image.size.width/2, y: image.size.height/2)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CILightTunnel: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            radius = NSNumber(value: slider.value)
        } else {
            rotation = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius,
                                                                         "inputRotation": self.rotation,
                                                                         "inputCenter": CIVector(x: self.image.size.width/2, y: self.image.size.height/2)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
