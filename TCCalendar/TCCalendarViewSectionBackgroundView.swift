//
//  TCCalendarViewSectionBackgroundView.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/11/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
//

import UIKit

class TCCalendarViewSectionBackgroundView: UICollectionReusableView {
    var monthLabel: UILabel!


    func initialize() {
        monthLabel = UILabel(frame: self.bounds)
        monthLabel.textAlignment = .Left
        monthLabel.font = UIFont.boldSystemFontOfSize(108)
        monthLabel.alpha = 0.1
        monthLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        monthLabel.layer.borderWidth = 1.0
        monthLabel.layer.borderColor = UIColor.orangeColor().CGColor
        self.addSubview(monthLabel)

        let views = ["monthLabel": monthLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[monthLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[monthLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

        self.backgroundColor = UIColor.clearColor()
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
