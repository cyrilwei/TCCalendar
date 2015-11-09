//
//  TCCalendarMonthTitleView.swift
//  TCCalendar
//
//  Copyright (c) 2015 Cyril Wei
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class TCCalendarMonthTitleView: UICollectionReusableView {
    var titleLabel: UILabel!

    var drawSeparatorLine: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }

    dynamic func titleFont() -> UIFont {
        return self.titleLabel?.font ?? UIFont.systemFontOfSize(UIFont.systemFontSize())
    }

    dynamic func setTitleFont(font: UIFont) {
        self.titleLabel?.font = font
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.drawSeparatorLine = true
    }
    
    func initialize() {
        self.backgroundColor = UIColor.clearColor()

        initTitleLabel()
    }

    private func initTitleLabel() {
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(titleLabel)

        let views = ["titleLabel": titleLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-18-[titleLabel]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }

    override func drawRect(rect: CGRect) {
        guard drawSeparatorLine else { return }

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