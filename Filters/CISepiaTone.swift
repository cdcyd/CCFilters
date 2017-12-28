//
//  CISepiaTone.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CISepiaTone: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CISepiaTone"
    private var inten = NSNumber(value: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "Inten", min: 0.0, max: 1.0, value: 1.0)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CISepiaTone
        系统：iOS5.0
        简介：Maps the colors of an image to various shades of brown.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputIntensity": inten])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CISepiaTone: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        inten = NSNumber(value: slider.value)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputIntensity": self.inten])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
