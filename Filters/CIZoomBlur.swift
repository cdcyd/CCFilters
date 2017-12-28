//
//  CIZoomBlur.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/21.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIZoomBlur: BaseFilter {

    private let image = UIImage("ImageC")
    private let name = "CIZoomBlur"
    private var center = CIVector(x: 150.0, y: 150.0)
    private var amount = NSNumber(value: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let point = PointView(title: "Center", X: 150.0, Y: 150.0)
        point.delegate = self
        self.view.addSubview(point)

        let slider = SliderView(title: "Amount", min: -200, max: 200, value: 20.0)
        slider.delegate = self
        slider.frame.origin.y = 300
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIZoomBlur(变焦模糊)
        系统：iOS8.3
        简介：Simulates the effect of zooming the camera while capturing the image.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: [kCIInputCenterKey: center, "inputAmount": amount])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIZoomBlur: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        amount = NSNumber(value: slider.value)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputCenterKey: self.center, "inputAmount": self.amount])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}

extension CIZoomBlur: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        center = point
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: [kCIInputCenterKey: self.center, "inputAmount": self.amount])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}


