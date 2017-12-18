//
//  UIImageExt.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/9/18.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

extension UIImage {

    convenience init(_ name:String) {
        self.init(named: name)!
    }

    func filter(name: String, parameters: [String:Any]) -> UIImage? {
        guard let image = self.cgImage else {
            return nil
        }

        #if DEBUG
        let filter = CIFilter(name: name)
        print(filter?.attributes as Any)
        #endif

        // 输入
        let input = CIImage(cgImage: image)

        // 输出
        let output = input.applyingFilter(name, parameters: parameters)

        // 渲染图片
        guard let cgimage = CIContext(options: nil).createCGImage(output, from: input.extent) else {
            return nil
        }
        return UIImage(cgImage: cgimage)
    }
    
}
