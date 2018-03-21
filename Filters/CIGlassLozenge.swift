//
//  CIGlassLozenge.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIGlassLozenge: BaseFilter {

    private let image = UIImage("ImageV")
    private let name = "CIGlassLozenge"
    private var p1 = CIVector(x: 150, y: 150)
    private var p2 = CIVector(x: 350, y: 150)
    private var radius = NSNumber(value: 100.0)
    private var refract = NSNumber(value: 1.70)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider1 = SliderView(title: "radius", min: 0.0, max: 1000.0, value: 100.0)
        slider1.tag = 100
        slider1.delegate = self
        self.view.addSubview(slider1)

        let slider2 = SliderView(title: "refract", min: 0.0, max: 5.0, value: 1.7)
        slider2.tag = 101
        slider2.delegate = self
        slider2.frame.origin.y = 300
        self.view.addSubview(slider2)

        let ptView1 = PointView(title: "point1", X: 150, Y: 150)
        ptView1.tag = 102
        ptView1.frame.origin.y = 330
        ptView1.delegate = self
        self.view.addSubview(ptView1)

        let ptView2 = PointView(title: "point2", X: 350, Y: 150)
        ptView1.tag = 104
        ptView2.frame.origin.y = 360
        ptView2.delegate = self
        self.view.addSubview(ptView2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIGlassLozenge
        系统：iOS9.0
        简介：Creates a lozenge-shaped lens and distorts the portion of the image over which the lens is placed.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputPoint0": p1,
                                                                      "inputPoint1": p2,
                                                                      "inputRadius": radius,
                                                                      "inputRefraction": refract])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIGlassLozenge: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            radius = NSNumber(value: slider.value)
        } else {
            refract = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputPoint0": self.p1,
                                                                         "inputPoint1": self.p2,
                                                                         "inputRadius": self.radius,
                                                                         "inputRefraction": self.refract])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}

extension CIGlassLozenge: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        if view.tag == 102 {
            p1 = point
        } else {
            p2 = point
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputPoint0": self.p1,
                                                                         "inputPoint1": self.p2,
                                                                         "inputRadius": self.radius,
                                                                         "inputRefraction": self.refract])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
