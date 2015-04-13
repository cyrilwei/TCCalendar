//
//  TCCalendarViewDayCell.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/11/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
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