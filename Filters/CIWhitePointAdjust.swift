//
//  CIWhitePointAdjust.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIWhitePointAdjust: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIWhitePointAdjust"
    private var color: CIColor = CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let view1 = RGBAView(title: "RGBA", R: 1.0, G: 1.0, B: 1.0, A: 1.0)
        view1.delegate = self
        self.view.addSubview(view1)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIWhitePointAdjust
        系统：iOS5.0
        简介：Adjusts the reference white point for an image and maps all colors in the source using the new reference.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputColor": color])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIWhitePointAdjust: RGBAViewDelegate {
    func didChangedValue(view: RGBAView, vector: CIVector) {
        color = CIColor(red: vector.x, green: vector.y, blue: vector.z, alpha: vector.w)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputColor": self.color])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
