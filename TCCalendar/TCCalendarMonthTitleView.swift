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

    func initialize() {
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(titleLabel)

        let views = ["titleLabel": titleLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.blackColor().CGColor
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