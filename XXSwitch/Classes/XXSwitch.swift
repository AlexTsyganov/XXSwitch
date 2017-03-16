//
//  XXSwitch.swift
//  XXSwith
//
//  Created by Alex Tsyganov on 15/03/2017.
//  Copyright © 2017 Brandwidth. All rights reserved.
//

import UIKit

@IBDesignable
class XXSwitch: UIControl {
    
    @IBInspectable var markerColor: UIColor = .white {
        didSet {
            marker.backgroundColor = markerColor
        }
    }
    
    @IBInspectable var bakgoundOffColor: UIColor = .darkGray {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var bakgoundOnColor: UIColor = .black {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var isOn: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    override var isSelected: Bool {
        set {
            isOn = newValue
        }
        get {
            return isOn
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    var tapGestureRecogniser: UITapGestureRecognizer!
    var panGestureRecogniser: UIPanGestureRecognizer!
    var previousStateOnPanAnimation: Bool?
    
    @IBOutlet var mergeView: [UIView]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(tapGestureRecogniser)
        panGestureRecogniser = UIPanGestureRecognizer.init(target: self, action: #selector(onMove))
        addGestureRecognizer(panGestureRecogniser)
    }
    
    func setOn(_ on: Bool, animate: Bool = true) {
        UIView.animate(withDuration: 0.14, delay: 0, options: [.curveEaseInOut], animations: {
            self.isOn = on
        }, completion: nil)
    }
    
    fileprivate let marker: UIView = {
        let m = UIView()
        m.translatesAutoresizingMaskIntoConstraints = false
        m.isUserInteractionEnabled = false
        return m
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.height*2, height: frame.height)
    }
    
    func updateUI() {
        let markerHeight = frame.height-2*borderWidth
        if !isOn {
            marker.frame = CGRect(x: borderWidth, y: borderWidth, width: markerHeight-borderWidth/2, height: markerHeight)
            backgroundColor = bakgoundOffColor
        } else {
            marker.frame = CGRect(x: frame.width/2+borderWidth, y: borderWidth, width: markerHeight, height: markerHeight)
            backgroundColor = bakgoundOnColor
        }
        if let borderColor = backgroundColor?.cgColor {
            layer.borderColor = borderColor
        }
        if let mergeView = mergeView {
            mergeView.forEach({ $0.tintColor = backgroundColor })
        }
        if marker.superview == nil {
            addSubview(marker)
        }
    }
    
    func onTap() {
        setOn(!isOn)
        sendActions(for: .valueChanged)
    }
    
    func onMove() {
        if panGestureRecogniser.state == .began {
            previousStateOnPanAnimation = isOn
        } else if panGestureRecogniser.state == .changed {
            let point = panGestureRecogniser.location(in: marker)
            let dx = marker.frame.width * 0.1
            if (isOn && point.x+dx < 0) || (!isOn && point.x-dx > marker.frame.width) {
                setOn(!isOn)
            }
        } else if panGestureRecogniser.state == .ended || panGestureRecogniser.state == .failed || panGestureRecogniser.state == .cancelled {
            if let previousStateOnPanAnimation = previousStateOnPanAnimation, previousStateOnPanAnimation != isOn {
                sendActions(for: .valueChanged)
            }
        }
    }
}
