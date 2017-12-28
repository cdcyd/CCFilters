//
//  MultipleView.swift
//  Filters
//
//  Created by cyd on 2017/12/27.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

protocol MultipleViewDelegate: NSObjectProtocol {
    func didChangedValue(view: MultipleView, vector: CIVector) -> Swift.Void
}

func floatArrayPointer(array: [CGFloat]) -> UnsafeMutablePointer<CGFloat> {
    var value = array
    return UnsafeMutableBufferPointer<CGFloat>(start: &value, count: value.count).baseAddress!
}

class MultipleView: UIView {

    weak var delegate: MultipleViewDelegate?

    private var title = [Float]()

    init(title: String, ps: [Float]) {
        super.init(frame: .zero)
        self.title = ps

        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.leftViewMode = .always
        tf.leftView = self.leftView(title: " " + title + ": ")
        tf.text = (ps as NSArray).componentsJoined(by: ",")
        tf.frame = CGRect(x: 5, y: 0, width: 300, height: tf.font!.lineHeight)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        tf.keyboardType = .numbersAndPunctuation
        self.addSubview(tf)

        self.frame = CGRect(x: 0, y: 250, width: tf.frame.maxX + 4, height: tf.font!.lineHeight)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @objc private func textDidChanged(_ tf: UITextField) {
        guard let texts = tf.text?.components(separatedBy: ",") else {
            return
        }

        var values = [CGFloat]()
        for text in texts {
            if Float(text) == nil {
                continue
            }
            values.append(CGFloat(Float(text)!))
        }

        if values.count != self.title.count {
            return
        }

        let result = UnsafeMutableBufferPointer<CGFloat>(start: &values, count: values.count)

        let vector = CIVector(values: result.baseAddress!, count: values.count)

        delegate?.didChangedValue(view: self, vector: vector)
    }

    @objc private func keyboardWillChanged(_ not: Notification) {
        let dic = not.userInfo! as NSDictionary
        let window = self.window
        let rect: CGRect = dic.value(forKey: UIKeyboardFrameEndUserInfoKey) as! CGRect
        let option: UIViewAnimationOptions = UIViewAnimationOptions.init(rawValue: dic.value(forKey: UIKeyboardAnimationCurveUserInfoKey) as! UInt)
        let duration: TimeInterval = dic.value(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval

        let frame: CGRect = self.superview!.convert(self.frame, to: window)
        let offsetY = rect.minY - frame.maxY

        var animationView = self.viewController()?.view
        if animationView == nil { animationView = window }
        if rect.minY >= (window?.frame.maxY)! {
            UIView.animate(withDuration: duration, delay: 0.0, options: option, animations: {
                animationView?.transform = CGAffineTransform.identity
            }, completion: nil)
        } else if offsetY < 0 {
            UIView.animate(withDuration: duration, delay: 0.0, options: option, animations: {
                animationView?.transform = (animationView?.transform.translatedBy(x: 0, y: offsetY))!
            }, completion: nil)
        }
    }

    private func viewController() -> UIViewController? {
        if self.next != nil && self.next!.isKind(of: UIViewController.self) {
            return self.next as? UIViewController
        }
        var superview = self.superview
        while superview != nil {
            if superview!.next != nil && superview!.next!.isKind(of: UIViewController.self) {
                return superview!.next as? UIViewController
            }
            superview = superview?.superview
        }
        return nil
    }

    private func leftView(title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = title
        label.sizeToFit()
        return label
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
