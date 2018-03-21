//
//  CILinearBurnBlendMode.swift
//  Filters
//
//  Created by cyd on 2017/12/28.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CILinearBurnBlendMode: BaseFilter {

    private let image = UIImage("ImageP")
    private let back = CIImage.init(cgImage: UIImage("ImageQ").cgImage!)
    private let name = "CILinearBurnBlendMode"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView1.image = image
        self.imageView2.image = UIImage(ciImage: back)

        self.setupFilterImageView()
        self.setupDescription()
    }

    private func setupFilterImageView() {
        let view = UIImageView(frame: CGRect(x: BaseFilter.screenW/4, y: self.imageView2.frame.maxY + 5, width: BaseFilter.screenW/2, height: 200))
        self.view.addSubview(view)

        view.image = image.filter(name: name, parameters: ["inputBackgroundImage": back])
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CILinearBurnBlendMode
        系统：iOS8.0
        简介：Darkens the background image samples to reflect the source image samples while also increasing contrast.
        详情：The effect of this filter is similar to that of the CIColorBurnBlendMode filter, but more pronounced.
        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
