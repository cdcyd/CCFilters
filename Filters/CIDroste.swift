//
//  CIDroste.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIDroste: BaseFilter {

    private let image = UIImage("ImageT")
    private let name = "CIDroste"
    private var p1 = CIVector(x: 50, y: 50)
    private var p2 = CIVector(x: 150, y: 150)
    private var strand = NSNumber(value: 1.0)
    private var period = NSNumber(value: 1.0)
    private var ratate = NSNumber(value: 0.0)
    private var zoom = NSNumber(value: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider1 = SliderView(title: "strand", min: -10.0, max: 10.0, value: 1.0)
        slider1.delegate = self
        slider1.slider.tag = 100
        slider1.frame.origin.y = 220
        self.view.addSubview(slider1)

        let slider2 = SliderView(title: "period", min: 1.0, max: 5.0, value: 1.0)
        slider2.delegate = self
        slider2.slider.tag = 101
        slider2.frame.origin.y = 250
        self.view.addSubview(slider2)

        let slider3 = SliderView(title: "ratate", min: 0.0, max: 6.283185307179586, value: 0.00)
        slider3.delegate = self
        slider3.slider.tag = 102
        slider3.frame.origin.y = 280
        self.view.addSubview(slider3)

        let slider4 = SliderView(title: "zoom", min: 0.01, max: 5.0, value: 1.0)
        slider4.delegate = self
        slider4.slider.tag = 103
        slider4.frame.origin.y = 310
        self.view.addSubview(slider4)

        let ptView1 = PointView(title: "point0", X: 50, Y: 50)
        ptView1.tag = 104
        ptView1.frame.origin.y = 340
        ptView1.delegate = self
        self.view.addSubview(ptView1)

        let ptView2 = PointView(title: "point1", X: 150, Y: 150)
        ptView1.tag = 105
        ptView2.frame.origin.y = 370
        ptView2.delegate = self
        self.view.addSubview(ptView2)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIDroste
        系统：iOS9.0
        简介：Recursively draws a portion of an image in imitation of an M. C. Escher drawing.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputInsetPoint0": p1,
                                                                      "inputInsetPoint1": p1,
                                                                      "inputStrands": strand,
                                                                      "inputPeriodicity": period,
                                                                      "inputRotation": ratate,
                                                                      "inputZoom": zoom])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIDroste: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        if view.tag == 104 {
            p1 = point
        } else if view.tag == 105 {
            p2 = point
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputInsetPoint0": self.p1,
                                                                         "inputInsetPoint1": self.p1,
                                                                         "inputStrands": self.strand,
                                                                         "inputPeriodicity": self.period,
                                                                         "inputRotation": self.ratate,
                                                                         "inputZoom": self.zoom])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}

extension CIDroste: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        if slider.tag == 100 {
            strand = NSNumber(value: slider.value)
        } else if slider.tag == 101 {
            period = NSNumber(value: slider.value)
        } else if slider.tag == 102 {
            ratate = NSNumber(value: slider.value)
        } else if slider.tag == 103 {
            zoom = NSNumber(value: slider.value)
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputInsetPoint0": self.p1,
                                                                         "inputInsetPoint1": self.p1,
                                                                         "inputStrands": self.strand,
                                                                         "inputPeriodicity": self.period,
                                                                         "inputRotation": self.ratate,
                                                                         "inputZoom": self.zoom])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
