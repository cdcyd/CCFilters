//
//  SliderView.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/9/15.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

protocol SliderViewDelegate: NSObjectProtocol {
    func didChangedValue(slider: UISlider) -> Swift.Void
}

class SliderView: UIView {

    weak var delegate:SliderViewDelegate?

    var slider: UISlider!

    private var valueLabel:UILabel!

    init(title:String, min:Float = 0, max:Float = 100, value:Float = 10) {
        super.init(frame: .zero)
    
        let label = UILabel(frame: .zero)
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.frame.origin.x = 5
        self.addSubview(label)
        
        let slider = UISlider(frame: CGRect(x: label.frame.maxX+5, y: 0, width: 200, height: label.bounds.height))
        slider.isContinuous = false
        slider.minimumValue = min
        slider.maximumValue = max
        slider.setValue(value, animated: false)
        slider.addTarget(self, action: #selector(SliderView.valueChanged(slider:)), for: .valueChanged)
        self.addSubview(slider)
        self.slider = slider
        
        let valueLabel = UILabel(frame: CGRect(x: slider.frame.maxX+5, y: 0, width: 60, height: label.bounds.height))
        valueLabel.text = String(value)
        valueLabel.textColor = UIColor.gray
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(valueLabel)
        self.valueLabel = valueLabel

        self.frame = CGRect(x: 0, y: 250, width: valueLabel.frame.maxX + 4, height: label.bounds.height)
    }
    
    @objc private func valueChanged(slider:UISlider) {
        self.valueLabel.text = String.init(format: "%.2f", slider.value)
        delegate?.didChangedValue(slider: slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
