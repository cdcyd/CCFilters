//
//  CIVignette.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIVignette: BaseFilter {

    private let image = UIImage("ImageM")
    private let name = "CIVignette"
    private var inten = NSNumber(value: 0.0)
    private var radius = NSNumber(value: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let redius = SliderView(title: "redius", min: 0.0, max: 2.0, value: 1.0)
        redius.delegate = self
        redius.tag = 100
        self.view.addSubview(redius)

        let slider = SliderView(title: "Inten  ", min: -1.0, max: 1.0, value: 0.0)
        slider.delegate = self
        slider.tag = 101
        slider.frame.origin.y = 300
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIVignette
        系统：iOS5.0
        简介：Reduces the brightness of an image at the periphery.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRadius": radius, "inputIntensity": inten])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIVignette: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        slider.tag == 100 ? (radius = NSNumber(value: slider.value)) : (inten = NSNumber(value: slider.value) )
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": self.radius, "inputIntensity": self.inten])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
