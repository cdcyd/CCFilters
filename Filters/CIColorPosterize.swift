//
//  CIColorPosterize.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorPosterize: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIColorPosterize"
    private var level = NSNumber(value: 6.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider = SliderView(title: "Level", min: 2.0, max: 30.0, value: 6.0)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorPosterize
        系统：iOS6.0
        简介：Remaps red, green, and blue color components to the number of brightness values you specify for each color component.
        详情：This filter flattens colors to achieve a look similar to that of a silk-screened poster
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputLevels": level])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorPosterize: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        level = NSNumber(value: slider.value)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputLevels": self.level])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
