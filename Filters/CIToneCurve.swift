//
//  CIToneCurve.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIToneCurve: BaseFilter {

    private let image = UIImage("ImageH")
    private let name = "CIToneCurve"
    private var PT0 = CIVector(x: 0.0, y: 0.0)
    private var PT1 = CIVector(x: 0.25, y: 0.25)
    private var PT2 = CIVector(x: 0.5, y: 0.5)
    private var PT3 = CIVector(x: 0.75, y: 0.75)
    private var PT4 = CIVector(x: 1.0, y: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let offset1 = PointView(title: "PT0", X: 0.0, Y: 0.0)
        offset1.delegate = self
        offset1.tag = 100
        offset1.frame.origin.y = 220
        self.view.addSubview(offset1)

        let offset2 = PointView(title: "PT1", X: 0.25, Y: 0.25)
        offset2.delegate = self
        offset2.tag = 101
        offset2.frame.origin.y = 260
        self.view.addSubview(offset2)

        let offset3 = PointView(title: "PT2", X: 0.5, Y: 0.5)
        offset3.delegate = self
        offset3.tag = 102
        offset3.frame.origin.y = 300
        self.view.addSubview(offset3)

        let offset4 = PointView(title: "PT3", X: 0.75, Y: 0.75)
        offset4.delegate = self
        offset4.tag = 103
        offset4.frame.origin.y = 340
        self.view.addSubview(offset4)

        let offset5 = PointView(title: "PT4", X: 1.0, Y: 1.0)
        offset5.delegate = self
        offset5.tag = 104
        offset5.frame.origin.y = 380
        self.view.addSubview(offset5)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIToneCurve
        系统：iOS5.0
        简介：Adjusts tone response of the R, G, and B channels of an image.
        详情：The input points are five x,y values that are interpolated using a spline curve. The curve is applied in a perceptual (gamma 2) version of the working space.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputPoint0": PT0,
                                                                      "inputPoint1": PT1,
                                                                      "inputPoint2": PT2,
                                                                      "inputPoint3": PT3,
                                                                      "inputPoint4": PT4])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIToneCurve: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        if view.tag == 100 {
            PT0 = point
        } else if view.tag == 101 {
            PT1 = point
        } else if view.tag == 102 {
            PT2 = point
        } else if view.tag == 103 {
            PT3 = point
        } else if view.tag == 104 {
            PT4 = point
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputPoint0": self.PT0,
                                                                         "inputPoint1": self.PT1,
                                                                         "inputPoint2": self.PT2,
                                                                         "inputPoint3": self.PT3,
                                                                         "inputPoint4": self.PT4])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
