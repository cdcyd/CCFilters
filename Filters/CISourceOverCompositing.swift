//
//  CISourceOverCompositing.swift
//  Filters
//
//  Created by cyd on 2017/12/28.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CISourceOverCompositing: BaseFilter {

    private let image = UIImage("ImageO")
    private let back = CIImage.init(cgImage: UIImage("ImageN").cgImage!)
    private let name = "CISourceOverCompositing"

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
        滤镜：CISourceOverCompositing
        系统：iOS6.0
        简介：Uses the background image to define what to take out of the input image.
        详情：The formula used to create this filter is described in Thomas Porter and Tom Duff. 1984. Compositing Digital Images. Computer Graphics, 18 (3): 253-259.
        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
