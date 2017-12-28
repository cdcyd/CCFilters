//
//  CIScreenBlendMode.swift
//  Filters
//
//  Created by cyd on 2017/12/28.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIScreenBlendMode: BaseFilter {

    let image = UIImage("ImageO")
    let back = CIImage.init(cgImage: UIImage("ImageN").cgImage!)
    let name = "CIScreenBlendMode"

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
        滤镜：CIScreenBlendMode
        系统：iOS6.0
        简介：Multiplies the inverse of the input image samples with the inverse of the background image samples.
        详情：This results in colors that are at least as light as either of the two contributing sample colors. The formula used to create this filter is described in the PDF specification, which is available online from the Adobe Developer Center. See PDF Reference and Adobe Extensions to the PDF Specification.
        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
