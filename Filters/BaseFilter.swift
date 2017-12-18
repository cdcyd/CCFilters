//
//  BaseFilter.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/9/15.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class BaseFilter: UIViewController {

    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height
    static let navigationH = UIApplication.shared.statusBarFrame.height + UINavigationController().navigationBar.frame.height
    
    let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW/2, height: 200))
    let imageView2 = UIImageView(frame: CGRect(x: screenW/2, y: 0, width: screenW/2, height: 200))

    let descView = UITextView(frame: CGRect(x: 0, y: screenH-navigationH-200, width: screenW, height: 200-80))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        self.view.addSubview(descView)
        descView.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
