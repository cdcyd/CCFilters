//
//  CIColorMatrix.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class CIColorMatrix: BaseFilter {

    private let image = UIImage("ImageE")
    private let name = "CIColorMatrix"
    private var R: CIVector = CIVector(x: 1, y: 0, z: 0, w: 0)
    private var G: CIVector = CIVector(x: 0, y: 1, z: 0, w: 0)
    private var B: CIVector = CIVector(x: 0, y: 0, z: 1, w: 0)
    private var A: CIVector = CIVector(x: 0, y: 0, z: 0, w: 1)
    private var S: CIVector = CIVector(x: 0, y: 0, z: 0, w: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupDescription()
        self.setupImages()
    }

    private func setupViews() {
        let view1 = RGBAView(title: "R ", R: 1, G: 0, B: 0, A: 0)
        view1.tag = 100
        view1.frame.origin.y = 220
        view1.delegate = self
        self.view.addSubview(view1)

        let view2 = RGBAView(title: "G ", R: 0, G: 1, B: 0, A: 0)
        view2.tag = 101
        view2.frame.origin.y = 260
        view2.delegate = self
        self.view.addSubview(view2)

        let view3 = RGBAView(title: "B ", R: 0, G: 0, B: 1, A: 0)
        view3.tag = 102
        view3.frame.origin.y = 300
        view3.delegate = self
        self.view.addSubview(view3)

        let view4 = RGBAView(title: "A ", R: 0, G: 0, B: 0, A: 1)
        view4.tag = 103
        view4.frame.origin.y = 340
        view4.delegate = self
        self.view.addSubview(view4)

        let view5 = RGBAView(title: "S ", R: 0, G: 0, B: 0, A: 0)
        view5.tag = 104
        view5.frame.origin.y = 380
        view5.delegate = self
        self.view.addSubview(view5)
    }

    private func setupDescription() {
        self.descView.text = """
        滤镜：CIColorMatrix
        系统：iOS5.0
        详情：This filter performs a matrix multiplication, as follows, to transform the color vector:
        s.r = dot(s, redVector)
        s.g = dot(s, greenVector)
        s.b = dot(s, blueVector)
        s.a = dot(s, alphaVector)
        s = s + bias
        """
    }

    private func setupImages() {
        self.imageView1.image = image
        self.imageView2.image = image.filter(name: name, parameters: ["inputRVector": R,
                                                                      "inputGVector": G,
                                                                      "inputBVector": B,
                                                                      "inputAVector": A,
                                                                      "inputBiasVector": S])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CIColorMatrix: RGBAViewDelegate {
    func didChangedValue(view: RGBAView, vector: CIVector) {
        if view.tag == 100 {
            R = vector
        } else if view.tag == 101 {
            G = vector
        } else if view.tag == 102 {
            B = vector
        } else if view.tag == 103 {
            A = vector
        } else if view.tag == 104 {
            S = vector
        }
        DispatchQueue.global().async {
            let output = self.image.filter(name: self.name, parameters: ["inputRVector": self.R,
                                                                         "inputGVector": self.G,
                                                                         "inputBVector": self.B,
                                                                         "inputAVector": self.A,
                                                                         "inputBiasVector": self.S])
            DispatchQueue.main.async {
                self.imageView2.image = output
            }
        }
    }
}
