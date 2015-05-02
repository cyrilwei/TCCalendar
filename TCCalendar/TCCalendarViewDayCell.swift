//
//  TCCalendarViewDayCell.swift
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

class TCCalendarViewDayCell: UICollectionViewCell {
    var dayLabel: UILabel!
    var date: NSDate!

    override func prepareForReuse() {
        super.prepareForReuse()

        dayLabel.text = ""
        dayLabel.textColor = UIColor.blackColor()
        dayLabel.font = UIFont.systemFontOfSize(18)
    }

    func initialize() {
        dayLabel = UILabel(frame: self.bounds)
        dayLabel.textAlignment = .Center
        dayLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(dayLabel)

        let views = ["dayLabel": dayLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[dayLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[dayLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }
}