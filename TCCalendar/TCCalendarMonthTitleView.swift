//
//  TCCalendarMonthTitleView.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/11/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
//

import UIKit

class TCCalendarMonthTitleView: UICollectionReusableView {
    var titleLabel: UILabel!
    var drawSeparatorLine: Bool = true

    override func prepareForReuse() {
        super.prepareForReuse()

        self.drawSeparatorLine = true
    }
    
    func initialize() {
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(titleLabel)

        let views = ["titleLabel": titleLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }

    override func drawRect(rect: CGRect) {
        if drawSeparatorLine {
            let context = UIGraphicsGetCurrentContext()

            CGContextSetAllowsAntialiasing(context, false)
            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextSetLineWidth(context, 1.0)
            CGContextMoveToPoint(context, 0.0, 0.0)
            CGContextAddLineToPoint(context, self.bounds.width, 0.0)
            CGContextStrokePath(context)
            CGContextSetAllowsAntialiasing(context, true)
        }
    }
}