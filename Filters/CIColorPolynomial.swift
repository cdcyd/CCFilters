//
//  CIColorPolynomial.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorPolynomial: BaseFilter {

    private let image = UIImage("ImageF")
    private let name = "CIColorPolynomial"
    private var R: CIVector = CIVector(x: 0, y: 1, z: 0, w: 0)
    private var G: CIVector = CIVector(x: 0, y: 1, z: 0, w: 0)
    private var B: CIVector = CIVector(x: 0, y: 1, z: 0, w: 0)
    private var A: CIVector = CIVector(x: 0, y: 1, z: 0, w: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let view1 = RGBAView(title: "R ", X: 0, Y: 1, Z: 0, W: 0)
        view1.tag = 100
        view1.frame.origin.y = 220
        view1.delegate = self
        self.view.addSubview(view1)

        let view2 = RGBAView(title: "G ", X: 0, Y: 1, Z: 0, W: 0)
        view2.tag = 101
        view2.frame.origin.y = 260
        view2.delegate = self
        self.view.addSubview(view2)

        let view3 = RGBAView(title: "B ", X: 0, Y: 1, Z: 0, W: 0)
        view3.tag = 102
        view3.frame.origin.y = 300
        view3.delegate = self
        self.view.addSubview(view3)

        let view4 = RGBAView(title: "A ", X: 0, Y: 1, Z: 0, W: 0)
        view4.tag = 103
        view4.frame.origin.y = 340
        view4.delegate = self
        self.view.addSubview(view4)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorPolynomial
        系统：iOS7.0
        详情：For each pixel, the value of each color component is treated as the input to a cubic polynomial, whose coefficients are taken from the corresponding input coefficients parameter in ascending order. Equivalent to the following formula:
        r = rCoeff[0] + rCoeff[1] * r + rCoeff[2] * r*r + rCoeff[3] * r*r*r
        g = gCoeff[0] + gCoeff[1] * g + gCoeff[2] * g*g + gCoeff[3] * g*g*g
        b = bCoeff[0] + bCoeff[1] * b + bCoeff[2] * b*b + bCoeff[3] * b*b*b
        a = aCoeff[0] + aCoeff[1] * a + aCoeff[2] * a*a + aCoeff[3] * a*a*a
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRedCoefficients": R,
                                                                      "inputGreenCoefficients": G,
                                                                      "inputBlueCoefficients": B,
                                                                      "inputAlphaCoefficients": A])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorPolynomial: RGBAViewDelegate {
    func didChangedValue(view: RGBAView, vector: CIVector) {
        if view.tag == 100 {
            R = vector
        } else if view.tag == 101 {
            G = vector
        } else if view.tag == 102 {
            B = vector
        } else if view.tag == 103 {
            A = vector
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRedCoefficients": self.R,
                                                                         "inputGreenCoefficients": self.G,
                                                                         "inputBlueCoefficients": self.B,
                                                                         "inputAlphaCoefficients": self.A])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
