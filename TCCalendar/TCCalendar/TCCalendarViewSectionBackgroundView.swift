//
//  TCCalendarViewSectionBackgroundView.swift
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

class TCCalendarViewSectionBackgroundView: UICollectionReusableView {
    var monthLabel: UILabel!
    var contentOffset: UIOffset! {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    func initialize() {
        self.backgroundColor = UIColor.clearColor()

        monthLabel = UILabel(frame: self.bounds)
        monthLabel.textAlignment = .Left
        monthLabel.font = UIFont.boldSystemFontOfSize(108)
        monthLabel.alpha = 0.1
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(monthLabel)

        contentOffset = UIOffsetMake(10, -14)
    }

    override func updateConstraints() {
        super.updateConstraints()

        let offsetHorizontal = contentOffset.horizontal ?? 0
        let offsetVertical = contentOffset.vertical ?? 0

        let views = ["monthLabel": monthLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(offsetHorizontal))-[monthLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(\(offsetVertical))-[monthLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
}

extension TCCalendarViewSectionBackgroundView {
    dynamic func setFont(font: UIFont) {
        self.monthLabel?.font = font
    }

    dynamic func setTextColor(color: UIColor) {
        self.monthLabel?.textColor = color
    }

    dynamic func setTextAlpha(alpha: CGFloat) {
        self.monthLabel?.alpha = alpha
    }

    dynamic func setTextOffset(offset: UIOffset) {
        self.contentOffset = offset
    }
}
