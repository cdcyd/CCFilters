//
//  CIMaskedVariableBlur.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/20.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIMaskedVariableBlur: BaseFilter {

    private let image = UIImage("ImageB")
    private let name = "CIMaskedVariableBlur"
    private let mask = CIImage(cgImage: UIImage("Mask").cgImage!)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSliderViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupSliderViews() {
        let slider = SliderView(title: "模糊度", min: 0, max: 10, value: 5)
        slider.delegate = self
        self.view.addSubview(slider)
    }

    private func setupDescription() {
        self.descView.text = "滤镜：CIMaskedVariableBlur，提供和目标图像相同大小的灰度图像为它指定模糊半径，并且白色的区域模糊度最高，黑色区域则没有模糊\n系统：iOS8.0\n参数：inputMask，用于模糊的遮罩图片\n           inputRadius，默认5.0，最小0.0，最大10.0"
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRadius": NSNumber(value: 5), "inputMask": mask])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIMaskedVariableBlur: SliderViewDelegate {
    func valueChanged(slider: UISlider) {
        let value = slider.value
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRadius": NSNumber(value: value), "inputMask": self.mask])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
