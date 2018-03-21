//
//  CIColorBurnBlendMode.swift
//  Filters
//
//  Created by cyd on 2017/12/28.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorBurnBlendMode: BaseFilter {

    private let image = UIImage("ImageO")
    private let back = CIImage.init(cgImage: UIImage("ImageN").cgImage!)
    private let name = "CIColorBurnBlendMode"

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
        滤镜：CIColorBurnBlendMode
        系统：iOS6.0
        简介：Darkens the background image samples to reflect the source image samples.
        详情：Source image sample values that specify white do not produce a change. The formula used to create this filter is described in the PDF specification, which is available online from the Adobe Developer Center. See PDF Reference and Adobe Extensions to the PDF Specification.
        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
