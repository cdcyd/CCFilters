//
//  CIColorMonochrome.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorMonochrome: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIColorMonochrome"
    private var color = CIColor(red: 0.6, green: 0.45, blue: 0.3, alpha: 1)
    private var amount = NSNumber(value: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let center = RGBAView(title: "Color", R: 0.6, G: 0.45, B: 0.3, A: 1)
        center.delegate = self
        self.view.addSubview(center)

        let slider2 = SliderView(title: "Inten", min: 0.0, max: 1.0, value: 1.0)
        slider2.delegate = self
        slider2.frame.origin.y = 300
        self.view.addSubview(slider2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorMonochrome
        系统：iOS5.0
        简介：Remaps colors so they fall within shades of a single color.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputColor": color, "inputIntensity": amount])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorMonochrome: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        amount = NSNumber(value: slider.value)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputColor": self.color, "inputIntensity": self.amount])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}

extension CIColorMonochrome: RGBAViewDelegate {
    func didChangedValue(view: RGBAView, vector: CIVector) {
        color = CIColor(red: vector.x, green: vector.y, blue: vector.z, alpha: vector.w)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputColor": self.color, "inputIntensity": self.amount])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
