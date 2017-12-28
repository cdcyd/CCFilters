//
//  CIColorCube.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorCube: BaseFilter {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDescription()
        self.setupImages()
    }

    private func setupDescription() {
        self.descView.text = ""
    }

    private func setupImages() {
        self.imageView1.image = UIImage("ImageJ.jpg")
        self.imageView2.image = UIImage.colorCubeInput("ImageJ.jpg", color: "Color", dimension: Int(64))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

