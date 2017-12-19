//
//  CIVibrance.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIVibrance: BaseFilter {

    private let image = UIImage("ImageH")
    private let name = "CIVibrance"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "Amount", min: -1.0, max: 1.0, value: 0)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIVibrance
        系统：iOS5.0
        简介：Adjusts the saturation of an image while keeping pleasing skin tones.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputAmount": NSNumber(value: 0)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIVibrance: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputAmount": NSNumber(value: value)])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
