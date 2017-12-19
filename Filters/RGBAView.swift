//
//  RGBAView.swift
//  Filters
//
//  Created by cyd on 2017/12/19.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

protocol RGBAViewDelegate: NSObjectProtocol {
    func didChangedValue(view: RGBAView, vector: CIVector) -> Swift.Void
}

class RGBAView: UIView {

    weak var delegate: RGBAViewDelegate?

    private var tf1: UITextField!
    private var tf2: UITextField!
    private var tf3: UITextField!
    private var tf4: UITextField!

    init(title: String, X: Float, Y: Float, Z: Float, W: Float) {
        super.init(frame: .zero)

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = title
        label.sizeToFit()
        label.frame.origin.x = 5
        self.addSubview(label)

        let tf1 = UITextField()
        tf1.font = UIFont.systemFont(ofSize: 14)
        tf1.leftViewMode = .always
        tf1.leftView = self.leftView(title: " X:")
        tf1.text = "\(X)"
        tf1.frame = CGRect(x: label.frame.maxX + 5, y: 0, width: 66, height: tf1.font!.lineHeight)
        tf1.borderStyle = .roundedRect
        tf1.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        tf1.keyboardType = .decimalPad
        self.addSubview(tf1)
        self.tf1 = tf1

        let tf2 = UITextField()
        tf2.font = UIFont.systemFont(ofSize: 14)
        tf2.leftViewMode = .always
        tf2.leftView = self.leftView(title: " Y:")
        tf2.text = "\(Y)"
        tf2.frame = CGRect(x: tf1.frame.maxX + 5, y: 0, width: 66, height: tf2.font!.lineHeight)
        tf2.borderStyle = .roundedRect
        tf2.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        tf2.keyboardType = .decimalPad
        self.addSubview(tf2)
        self.tf2 = tf2

        let tf3 = UITextField()
        tf3.font = UIFont.systemFont(ofSize: 14)
        tf3.leftViewMode = .always
        tf3.leftView = self.leftView(title: " Z:")
        tf3.text = "\(Z)"
        tf3.frame = CGRect(x: tf2.frame.maxX + 5, y: 0, width: 66, height: tf3.font!.lineHeight)
        tf3.borderStyle = .roundedRect
        tf3.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        tf3.keyboardType = .decimalPad
        self.addSubview(tf3)
        self.tf3 = tf3

        let tf4 = UITextField()
        tf4.font = UIFont.systemFont(ofSize: 14)
        tf4.leftViewMode = .always
        tf4.leftView = self.leftView(title: " W:")
        tf4.text = "\(W)"
        tf4.frame = CGRect(x: tf3.frame.maxX + 5, y: 0, width: 66, height: tf4.font!.lineHeight)
        tf4.borderStyle = .roundedRect
        tf4.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        tf4.keyboardType = .decimalPad
        self.addSubview(tf4)
        self.tf4 = tf4

        self.frame = CGRect(x: 0, y: 250, width: tf4.frame.maxX + 4, height: tf4.font!.lineHeight)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @objc private func textDidChanged(_ tf: UITextField) {
        let ci = CIVector(x: CGFloat(Float(tf1.text ?? "0") ?? 0.0),
                          y: CGFloat(Float(tf2.text ?? "0") ?? 0.0),
                          z: CGFloat(Float(tf3.text ?? "0") ?? 0.0),
                          w: CGFloat(Float(tf4.text ?? "0") ?? 0.0))
        delegate?.didChangedValue(view: self, vector: ci)
    }

    @objc private func keyboardWillChanged(_ not: Notification) {
        if tf1.isFirstResponder {
            self.keyboardAnimation(dic: not.userInfo! as NSDictionary)
        } else if tf2.isFirstResponder {
            self.keyboardAnimation(dic: not.userInfo! as NSDictionary)
        } else if tf3.isFirstResponder {
            self.keyboardAnimation(dic: not.userInfo! as NSDictionary)
        } else if tf4.isFirstResponder {
            self.keyboardAnimation(dic: not.userInfo! as NSDictionary)
        }
    }

    private func keyboardAnimation(dic: NSDictionary) {
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
