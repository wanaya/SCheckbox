//
//  SCheckBox.swift
//  Soriana
//
//  Created by Guillermo Anaya Magallón on 25/09/14.
//  Copyright (c) 2014 wanaya. All rights reserved.
//

import UIKit

class SCheckBox: UIControl {
    
    let textLabel = UILabel()
    private let DefaultSideLength = CGFloat(20.0)
    private var colors = [UInt: UIColor]()
    private var backgroundColors = [UInt: UIColor]()
    var checkboxSideLength = CGFloat(0.0)
    
    var checkboxColor:UIColor = UIColor.blackColor() {
        didSet {
            self.textLabel.textColor = self.checkboxColor
            self.setNeedsDisplay()
        }
    }
    
    var checked:Bool = false {
        didSet {
            self.setNeedsDisplay()
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.textLabel.frame = CGRectZero
        self.checkboxSideLength = DefaultSideLength
        self.checkboxColor = UIColor.blackColor()
        self.backgroundColor = UIColor.clearColor()
        self.textLabel.backgroundColor = UIColor.clearColor()
        
        self.addSubview(self.textLabel)
        
        self.addObserver(self, forKeyPath: "enabled", options: NSKeyValueObservingOptions.New, context: nil)
        self.addObserver(self, forKeyPath: "selected", options: NSKeyValueObservingOptions.New, context: nil)
        self.addObserver(self, forKeyPath: "highlighted", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    func color(color:UIColor, forState state:UIControlState) {
        self.colors[state.toRaw()] = color
        self.changeColorForState(self.state)
    }
    
    func backgroundColor(color:UIColor, forState state:UIControlState) {
        
        self.backgroundColors[state.toRaw()] = color
        self.changeBackgroundColorForState(self.state)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "enabled")
        self.removeObserver(self, forKeyPath: "selected")
        self.removeObserver(self, forKeyPath: "highlighted")
    }
    
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>) {
        switch keyPath {
            case "enabled", "selected", "highlighted":
            self.changeColorForState(self.state)
            
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    private func changeColorForState(state: UIControlState) {
        
        if let color = self.colors[state.toRaw()] {
            self.checkboxColor = color
            self.textLabel.textColor = color
        }
    }
    
    private func changeBackgroundColorForState(state: UIControlState) {
        
        if let color = self.backgroundColors[state.toRaw()] {
            self.backgroundColor = color
        }
    }
    
    override func drawRect(rect: CGRect) {
        let frame = CGRectIntegral(CGRectMake(0, (rect.size.height - self.checkboxSideLength) / 2.0, self.checkboxSideLength, self.checkboxSideLength))
        
        if self.checked {
            let bezierPath = UIBezierPath()
            
            bezierPath.moveToPoint(CGPointMake(CGRectGetMinX(frame) + 0.75000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21875 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.40000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52500 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.28125 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37500 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.17500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47500 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.40000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75000 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.81250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28125 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.75000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21875 * CGRectGetHeight(frame)))
            bezierPath.closePath()
            
            self.checkboxColor.setFill()
            bezierPath.fill()
        }
        
        let roundedRectanglePath = UIBezierPath(roundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.05000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.05000 + 0.5), floor(CGRectGetWidth(frame) * 0.95000 + 0.5) - floor(CGRectGetWidth(frame) * 0.05000 + 0.5), floor(CGRectGetHeight(frame) * 0.95000 + 0.5) - floor(CGRectGetHeight(frame) * 0.05000 + 0.5)), cornerRadius: 0.0)
        
        roundedRectanglePath.lineWidth = 2 * self.checkboxSideLength / DefaultSideLength
        self.checkboxColor.setStroke()
        roundedRectanglePath.stroke()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textLabelOriginX = self.checkboxSideLength + 5.0
        let textLabelMaxSize = CGSizeMake(CGRectGetWidth(self.bounds) - textLabelOriginX, CGRectGetHeight(self.bounds))
        let myNSString: NSString = NSString(string: self.textLabel.text!)
        var textLabelSize:CGSize =  myNSString.sizeWithAttributes([NSFontAttributeName: self.textLabel.font])
        self.textLabel.frame = CGRectIntegral(CGRectMake(textLabelOriginX, (CGRectGetHeight(self.bounds) - textLabelSize.height) / 2.0, textLabelSize.width, textLabelSize.height))
        
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        let location = touch.locationInView(self)
        if CGRectContainsPoint(self.bounds, location) {
            self.checked = !self.checked
        }
    }
}




