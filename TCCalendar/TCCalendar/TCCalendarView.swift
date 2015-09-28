//
//  TCCalendarView.swift
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

let TCCalendarViewDayCellIdentifier = "TCCalendarViewDayCellIdentifier"
let TCCalendarViewWeekdayCellIdentifier = "TCCalendarViewWeekdayCellIdentifier"
let TCCalendarMonthTitleKind = "TCCalendarMonthTitle"
let TCCalendarMonthTitleViewIdentifier = "TCCalendarMonthTitleViewIdentifier"
let TCCalendarViewSectionBackgroundKind = "TCCalendarViewSectionBackgroundKind"
let TCCalendarViewSectionBackgroundViewIdentifier = "TCCalendarViewSectionBackgroundViewIdentifier"

class TCCalendarView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var weekdaySymbols: [String]!
    var numberOfDaysInWeek: Int = 7

    var months = [NSDate]()
    var weekdayOfFirstDay = [Int]()
    var calendar: NSCalendar!

    var shouldEnableDateClosure: ((date: NSDate, calendar: NSCalendar) -> (Bool))?
    var shouldSelectDateClosure: ((date: NSDate, calendar: NSCalendar) -> (Bool))?
    var didSelectDateClosure: ((date: NSDate, calendar: NSCalendar) -> ())?
    
    var cellDecorateClosure: ((cell: TCCalendarViewDayCell, isEnabled: Bool) -> ())?

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

            repeat {
                months.append(dateForMonth)

                let weekdayComponents = calendar.components(.Weekday, fromDate: dateForMonth)
                weekdayOfFirstDay.append(weekdayComponents.weekday - 1)

                dateForMonth = calendar.dateByAddingComponents(monthComponents, toDate: dateForMonth, options: NSCalendarOptions())!
            } while(dateForMonth.compare(endDate) != NSComparisonResult.OrderedDescending)
        }

        self.reloadData()
    }


    func initialize() {
        self.registerClass(TCCalendarViewDayCell.self, forCellWithReuseIdentifier: TCCalendarViewDayCellIdentifier)
        self.registerClass(TCCalendarViewWeekdayCell.self, forCellWithReuseIdentifier: TCCalendarViewWeekdayCellIdentifier)
        self.registerClass(TCCalendarMonthTitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TCCalendarMonthTitleViewIdentifier)
        self.registerClass(TCCalendarViewSectionBackgroundView.self, forSupplementaryViewOfKind: TCCalendarViewSectionBackgroundKind, withReuseIdentifier: TCCalendarViewSectionBackgroundViewIdentifier)

        self.calendar = NSCalendar.currentCalendar()

        let formatter = NSDateFormatter()
        formatter.calendar = self.calendar
        self.weekdaySymbols = formatter.veryShortWeekdaySymbols as [String]
        self.numberOfDaysInWeek = self.weekdaySymbols.count

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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return months.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months[section].daysOfMonth(inCalendar: calendar) + weekdayOfFirstDay[section] + numberOfDaysInWeek
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item < numberOfDaysInWeek {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TCCalendarViewWeekdayCellIdentifier, forIndexPath: indexPath) as! TCCalendarViewWeekdayCell

            cell.weekdayLabel.text = weekdaySymbols[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TCCalendarViewDayCellIdentifier, forIndexPath: indexPath) as! TCCalendarViewDayCell

            let weekday = weekdayOfFirstDay[indexPath.section]
            if indexPath.item >= weekday + numberOfDaysInWeek {
                let day = indexPath.item - weekday - numberOfDaysInWeek + 1

                let month = months[indexPath.section]
                let components = calendar.components([.Year, .Month], fromDate: month)
                components.day = day

                let realDate = calendar.dateFromComponents(components)!

                cell.dayLabel.text = "\(day)"
                cell.date = realDate

                if realDate.compareWithoutTime(NSDate(), inCalendar: calendar) == .OrderedSame {
                    cell.dayLabel.font = UIFont.boldSystemFontOfSize(18)
                }
                
                cellDecorateClosure?(cell: cell, isEnabled: self.shouldEnableDateClosure?(date: realDate, calendar: calendar) ?? true)
            }
            
            return cell
        }
    }

    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let weekday = weekdayOfFirstDay[indexPath.section]
        if indexPath.item < weekday + numberOfDaysInWeek {
            return false
        }
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TCCalendarViewDayCell
        var result = true
        
        result = result && (shouldEnableDateClosure?(date: cell.date, calendar: calendar) ?? true)
        result = result && (shouldSelectDateClosure?(date: cell.date, calendar: calendar) ?? true)
        
        return result
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TCCalendarViewDayCell

        didSelectDateClosure?(date: cell.date, calendar: calendar)
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let titleView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: TCCalendarMonthTitleViewIdentifier, forIndexPath: indexPath) as! TCCalendarMonthTitleView
            titleView.backgroundColor = UIColor.clearColor()
            titleView.titleLabel.text = months[indexPath.section].longMonthString
            titleView.drawSeparatorLine = indexPath.section != 0

            return titleView
        } else {
            let bgView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: TCCalendarViewSectionBackgroundViewIdentifier, forIndexPath: indexPath) as! TCCalendarViewSectionBackgroundView

            bgView.monthLabel.text = months[indexPath.section].shortMonthString
            bgView.monthLabel.sizeToFit()
            bgView.setNeedsUpdateConstraints()

            return bgView
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let width      = self.bounds.width
        let itemWidth  = floor(width / CGFloat(numberOfDaysInWeek))
        let itemHeight = itemWidth
        
//        let miss = width - itemWidth * 7
//        println(" miss: \(miss)")

        return CGSizeMake(itemWidth, itemHeight)
    }
}