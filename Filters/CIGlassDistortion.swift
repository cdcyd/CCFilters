//
//  CIGlassDistortion.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIGlassDistortion: BaseFilter {

    private let image = UIImage("ImageV")
    private let texture = CIImage.init(cgImage: UIImage("ImageU").cgImage!)
    private let name = "CIGlassDistortion"
    private var center = CIVector(x: 150, y: 150)
    private var scale = NSNumber(value: 200.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let slider1 = SliderView(title: "scale", min: 0.01, max: 500.0, value: 200.0)
        slider1.delegate = self
        self.view.addSubview(slider1)

        let ptView1 = PointView(title: "center", X: 150, Y: 150)
        ptView1.frame.origin.y = 300
        ptView1.delegate = self
        self.view.addSubview(ptView1)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIGlassDistortion
        系统：iOS8.0
        简介：The raised portions of the output image are the result of applying a texture map.
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputTexture": texture,
                                                                      "inputCenter": center,
                                                                      "inputScale": scale])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIGlassDistortion: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        scale = NSNumber(value: slider.value)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputTexture": self.texture,
                                                                         "inputCenter": self.center,
                                                                         "inputScale": self.scale])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}

extension CIGlassDistortion: PointViewDelegate {
    func didChangedValue(view: PointView, point: CIVector) {
        center = point
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputTexture": self.texture,
                                                                         "inputCenter": self.center,
                                                                         "inputScale": self.scale])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
