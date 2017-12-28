//
//  CIFalseColor.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIFalseColor: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIFalseColor"
    private var color0 = CIColor(red: 0.3, green: 0.0, blue: 0.0, alpha: 1.0)
    private var color1 = CIColor(red: 1.0, green: 0.9, blue: 0.8, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let view1 = RGBAView(title: "Min", R: 0.3, G: 0, B: 0, A: 1)
        view1.tag = 100
        view1.delegate = self
        self.view.addSubview(view1)

        let view2 = RGBAView(title: "Max", R: 1.0, G: 0.9, B: 0.8, A: 1)
        view2.tag = 101
        view2.frame.origin.y = 300
        view2.delegate = self
        self.view.addSubview(view2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIFalseColor
        系统：iOS6.0
        简介：Maps luminance to a color ramp of two colors.
        详情：False color is often used to process astronomical and other scientific data, such as ultraviolet and x-ray images.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputColor0": color0, "inputColor1": color1])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIFalseColor: RGBAViewDelegate {
    func didChangedValue(view: RGBAView, vector: CIVector) {
        view.tag == 100 ? (color0 = CIColor(red: vector.x, green: vector.y, blue: vector.z, alpha: vector.w)) :
                          (color1 = CIColor(red: vector.x, green: vector.y, blue: vector.z, alpha: vector.w))
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputColor0": self.color0, "inputColor1": self.color1])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
