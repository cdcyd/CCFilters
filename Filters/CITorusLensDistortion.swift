//
//  CITorusLensDistortion.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CITorusLensDistortion: BaseFilter {

    private var imageView: UIImageView!
    private let image = UIImage("ImageR")
    private let name = "CITorusLensDistortion"
    private var radius = NSNumber(value: 160.0)
    private var width = NSNumber(value: 80.0)
    private var refract = NSNumber(value: 1.70)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupFilterImageView()
    }

    private func setupViews() {
        let slider = SliderView(title: "Radius", min: 0, max: 500, value: 160)
        slider.delegate = self
        slider.slider.tag = 100
        slider.frame.origin.y = 320
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "Refract", min: 0.0, max: 5.0, value: 1.70)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 350
        self.view.addSubview(slider1)

        let slider2 = SliderView(title: "width", min: 0.0, max: 200.0, value: 80.0)
        slider2.delegate = self
        slider2.slider.tag = 102
        slider2.frame.origin.y = 380
        self.view.addSubview(slider2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CITorusLensDistortion
        系统：iOS9.0
        简介：Creates a torus-shaped lens and distorts the portion of the image over which the lens is placed.
        """
    }

    private func setupFilterImageView() {
        let view = UIImageView(image: image)
        view.frame = CGRect(x: (BaseFilter.screenW - view.frame.width)/2, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(view)
        self.imageView = view
        view.image = image.filter(name: name, parameters: ["inputRadius": radius,
                                                           "inputRefraction": refract,
                                                           "inputWidth": width,
                                                           "inputCenter": CIVector(x: image.size.width/2, y: image.size.height/2)])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        self.updateFilter(touch)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        self.updateFilter(touch)
    }

    private func updateFilter(_ touch: UITouch?) {
        let point = touch?.preciseLocation(in: self.imageView)
        let height = self.imageView.frame.height
        if point != nil && point!.x > 0 && point!.y > 0 && point!.x < imageView.frame.width && point!.y < imageView.frame.height {
            DispatchQueue.global().async {
                let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius,
                                                                             "inputRefraction": self.refract,
                                                                             "inputWidth": self.width,
                                                                             "inputCenter": CIVector(x: point!.x, y: height - point!.y)])
                DispatchQueue.main.async {
                    self.imageView.image = output
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CITorusLensDistortion: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            radius = NSNumber(value: slider.value)
        } else if slider.tag == 101 {
            refract = NSNumber(value: slider.value)
        } else {
            width = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius,
                                                                         "inputRefraction": self.refract,
                                                                         "inputWidth": self.width,
                                                                         "inputCenter": CIVector(x: self.image.size.width/2, y: self.image.size.height/2)])
            DispatchQueue.main.async {
                self.imageView.image = output
            }
        }
    }
}
