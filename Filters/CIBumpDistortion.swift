//
//  CIBumpDistortion.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIBumpDistortion: BaseFilter {

    private var imageView: UIImageView!
    private let image = UIImage("ImageR")
    private let name = "CIBumpDistortion"
    private var radius = NSNumber(value: 300.0)
    private var scale = NSNumber(value: 0.50)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupFilterImageView()
    }

    private func setupViews() {
        let slider = SliderView(title: "Radius", min: 0, max: 600, value: 300)
        slider.delegate = self
        slider.slider.tag = 100
        slider.frame.origin.y = 320
        self.view.addSubview(slider)

        let slider1 = SliderView(title: "Scale", min: -1.0, max: 1.0, value: 0.50)
        slider1.delegate = self
        slider1.slider.tag = 101
        slider1.frame.origin.y = 360
        self.view.addSubview(slider1)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIBumpDistortion
        系统：iOS7.0
        简介：Creates a bump that originates at a specified point in the image.
        详情：The bump can be concave or convex.
        """
    }

    private func setupFilterImageView() {
        let view = UIImageView(image: image)
        view.frame = CGRect(x: (BaseFilter.screenW - view.frame.width)/2, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(view)
        self.imageView = view
        view.image = image.filter(name: name, parameters: ["inputRadius": radius,
                                                           "inputScale": scale,
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
                                                                             "inputScale": self.scale,
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

extension CIBumpDistortion: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            radius = NSNumber(value: slider.value)
        } else {
            scale = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius,
                                                                         "inputScale": self.scale,
                                                                         "inputCenter": CIVector(x: self.image.size.width/2, y: self.image.size.height/2)])
            DispatchQueue.main.async {
                self.imageView.image = output
            }
        }
    }
}
