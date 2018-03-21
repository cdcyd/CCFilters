//
//  CIDisplacementDistortion.swift
//  Filters
//
//  Created by cyd on 2018/1/8.
//  Copyright © 2018年 cyd. All rights reserved.
//

import UIKit

class CIDisplacementDistortion: BaseFilter {

    private let image = UIImage("ImageR")
    private let back = CIImage.init(cgImage: UIImage("ImageU").cgImage!)
    private let name = "CIDisplacementDistortion"
    private var scale = NSNumber(value: 50.0)
    private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView1.image = image
        self.imageView2.image = UIImage(ciImage: back)

        self.setupFilterImageView()
        self.setupViews()
        self.setupDescription()
    }

    private func setupViews() {
        let slider1 = SliderView(title: "scale", min: 0.0, max: 200.0, value: 50.0)
        slider1.delegate = self
        slider1.slider.tag = 100
        slider1.frame.origin.y = self.imageView2.frame.maxY + 5 + 200 + 10
        self.view.addSubview(slider1)
    }

    private func setupFilterImageView() {
        let view = UIImageView(frame: CGRect(x: BaseFilter.screenW/4, y: self.imageView2.frame.maxY + 5, width: BaseFilter.screenW/2, height: 200))
        self.imageView = view
        self.view.addSubview(view)

        view.image = image.filter(name: name, parameters: ["inputDisplacementImage": back,
                                                           "inputScale": scale])
    }

    private func setupDescription() {
        self.descView.frame.origin.y = self.imageView.frame.maxY + 50
        self.descView.text = """
        滤镜：CIDisplacementDistortion
        系统：iOS9.0
        简介：The output image has a texture defined by the grayscale values..
        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIDisplacementDistortion: SliderViewDelegate {
    func didChangedValue(slider: UISlider) {
        scale = NSNumber(value: slider.value)
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputDisplacementImage": self.back,
                                                                         "inputScale": self.scale])
            DispatchQueue.main.async {
                self.imageView.image = output
            }
        }
    }
}
