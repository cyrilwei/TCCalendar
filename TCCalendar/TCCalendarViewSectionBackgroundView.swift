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
        monthLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(monthLabel)

        contentOffset = UIOffsetMake(10, -14)
    }

    override func updateConstraints() {
        super.updateConstraints()

        let offsetHorizontal = contentOffset.horizontal ?? 0
        let offsetVertical = contentOffset.vertical ?? 0

        let views = ["monthLabel": monthLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(offsetHorizontal))-[monthLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(\(offsetVertical))-[monthLabel]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
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
