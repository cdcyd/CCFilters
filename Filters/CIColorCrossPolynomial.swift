//
//  CIColorCrossPolynomial.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorCrossPolynomial: BaseFilter {

    private let image = UIImage("ImageF")
    private let name = "CIColorCrossPolynomial"
    private var R = CIVector(values: floatArrayPointer(array: [1,0,0,0,0,0,0,0,0,0]), count: 10)
    private var G = CIVector(values: floatArrayPointer(array: [0,1,0,0,0,0,0,0,0,0]), count: 10)
    private var B = CIVector(values: floatArrayPointer(array: [0,0,1,0,0,0,0,0,0,0]), count: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let R = MultipleView(title: "Red   ", ps: [1,0,0,0,0,0,0,0,0,0])
        R.delegate = self
        R.tag = 100
        self.view.addSubview(R)

        let G = MultipleView(title: "Green", ps: [0,1,0,0,0,0,0,0,0,0])
        G.delegate = self
        G.tag = 101
        G.frame.origin.y = 300
        self.view.addSubview(G)

        let B = MultipleView(title: "Blue   ", ps: [0,0,1,0,0,0,0,0,0,0])
        B.delegate = self
        B.tag = 102
        B.frame.origin.y = 350
        self.view.addSubview(B)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorCrossPolynomial
        系统：iOS7.0
        公式：out.r = in.r * rC[0] + in.g * rC[1] + in.b * rC[2] + in.r * in.r * rC[3] + in.g * in.g * rC[4] + in.b * in.b * rC[5] + in.r * in.g * rC[6] + in.g * in.b * rC[7] + in.b * in.r * rC[8] + rC[9]
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRedCoefficients": R,
                                                                      "inputGreenCoefficients": G,
                                                                      "inputBlueCoefficients": B])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorCrossPolynomial: MultipleViewDelegate {
    func didChangedValue(view: MultipleView, vector: CIVector) {
        if view.tag == 100 {
            R = vector
        } else if view.tag == 101 {
            G = vector
        } else {
            B = vector
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRedCoefficients": self.R,
                                                                         "inputGreenCoefficients": self.G,
                                                                         "inputBlueCoefficients": self.B])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
