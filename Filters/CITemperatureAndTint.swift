//
//  CITemperatureAndTint.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CITemperatureAndTint: BaseFilter {

    private let image = UIImage("ImageH")
    private let name = "CITemperatureAndTint"
    private var offset1 = CIVector(x: 6500.0, y: 0.0)
    private var offset2 = CIVector(x: 6500.0, y: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let offset1 = PointView(title: "NL", X: 6500.0, Y: 0.0)
        offset1.delegate = self
        offset1.tag = 100
        self.view.addSubview(offset1)

        let offset2 = PointView(title: "TN", X: 6500.0, Y: 0.0)
        offset2.delegate = self
        offset2.tag = 101
        offset2.frame.origin.y = 300
        self.view.addSubview(offset2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CITemperatureAndTint
        系统：iOS5.0
        简介：Adapts the reference white point for an image.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputNeutral": offset1, "inputTargetNeutral": offset2])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CITemperatureAndTint: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        view.tag == 100 ? (offset1 = point) : (offset2 = point)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputNeutral": self.offset1, "inputTargetNeutral": self.offset2])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
