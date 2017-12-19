//
//  CIColorClamp.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/11/21.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorClamp: BaseFilter {

    private let image = UIImage("ImageD")
    private let name = "CIColorClamp"
    private var min: CIVector = CIVector(x: 0, y: 0, z: 0, w: 0)
    private var max: CIVector = CIVector(x: 1, y: 1, z: 1, w: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let view1 = RGBAView(title: "Min", X: 0, Y: 0, Z: 0, W: 0)
        view1.tag = 100
        view1.delegate = self
        self.view.addSubview(view1)

        let view2 = RGBAView(title: "Max", X: 1, Y: 1, Z: 1, W: 1)
        view2.tag = 101
        view2.frame.origin.y = 300
        view2.delegate = self
        self.view.addSubview(view2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorClamp
        系统：iOS7.0
        简介：Modifies color values to keep them within a specified range.
        详情：At each pixel, color component values less than those in inputMinComponents will be increased to match those in inputMinComponents, and color component values greater than those in inputMaxComponents will be decreased to match those in inputMaxComponents.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputMinComponents": min, "inputMaxComponents": max])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorClamp: RGBAViewDelegate {
    func didChangedValue(view: RGBAView, vector: CIVector) {
        view.tag == 100 ? (min = vector) : (max = vector)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputMinComponents": self.min, "inputMaxComponents": self.max])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
