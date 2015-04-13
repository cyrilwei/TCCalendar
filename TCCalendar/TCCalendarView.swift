//
//  TCCalendarView.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/11/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
//

import UIKit

let TCCalendarViewDayCellIdentifier = "TCCalendarViewDayCellIdentifier"
let TCCalendarMonthTitleKind = "TCCalendarMonthTitle"
let TCCalendarMonthTitleViewIdentifier = "TCCalendarMonthTitleViewIdentifier"
let TCCalendarViewSectionBackgroundKind = "TCCalendarViewSectionBackgroundKind"
let TCCalendarViewSectionBackgroundViewIdentifier = "TCCalendarViewSectionBackgroundViewIdentifier"

class TCCalendarView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var months = [NSDate]()
    var calendar: NSCalendar!

    var startDate: NSDate! {
        didSet {
            updateData()
        }
    }

    var endDate: NSDate! {
        didSet {
            updateData()
        }
    }

    private func updateData() {
        if startDate != nil && endDate != nil {
            var dateForMonth = startDate.firstDateOfMonth(inCalendar: calendar)

            let monthComponents = NSDateComponents()
            monthComponents.month = 1

            do {
                months.append(dateForMonth)

                dateForMonth = calendar.dateByAddingComponents(monthComponents, toDate: dateForMonth, options: NSCalendarOptions.allZeros)!
            } while(dateForMonth.compare(endDate) != NSComparisonResult.OrderedDescending)
        }

        self.reloadData()
    }


    func initialize() {
        self.registerClass(TCCalendarViewDayCell.self, forCellWithReuseIdentifier: TCCalendarViewDayCellIdentifier)
        self.registerClass(TCCalendarMonthTitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TCCalendarMonthTitleViewIdentifier)
        self.registerClass(TCCalendarViewSectionBackgroundView.self, forSupplementaryViewOfKind: TCCalendarViewSectionBackgroundKind, withReuseIdentifier: TCCalendarViewSectionBackgroundViewIdentifier)

        self.calendar = NSCalendar.currentCalendar()

        self.dataSource = self
        self.delegate = self

        self.collectionViewLayout = TCCalendarLayout()
        self.backgroundColor = UIColor.clearColor()

        self.startDate = NSDate()
        self.endDate = NSDate().dateByAddingTimeInterval(60*60*24*365)
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return months.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months[section].daysOfMonth(inCalendar: calendar)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TCCalendarViewDayCellIdentifier, forIndexPath: indexPath) as! TCCalendarViewDayCell

        cell.dayLabel.text = "\(indexPath.item + 1)"
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let titleView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: TCCalendarMonthTitleViewIdentifier, forIndexPath: indexPath) as! TCCalendarMonthTitleView
            titleView.backgroundColor = UIColor.clearColor()
            titleView.titleLabel.text = months[indexPath.section].longMonthString

            return titleView
        } else {
            let bgView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: TCCalendarViewSectionBackgroundViewIdentifier, forIndexPath: indexPath) as! TCCalendarViewSectionBackgroundView

            bgView.monthLabel.text = months[indexPath.section].shortMonthString
            bgView.monthLabel.sizeToFit()

            return bgView
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let width      = self.bounds.width
//        let miss = width - floor(width / 7) * 7
//
//        println(" miss: \(miss)")

        var itemWidth  = floor(width / 7)
        let itemHeight = itemWidth

//        if (indexPath.item % 7) % 2 == 0 {
//            itemWidth = itemWidth + 1
//        }

        return CGSizeMake(itemWidth, itemHeight)
    }
}