//
//  ViewController.swift
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

class ViewController: UIViewController {

    @IBOutlet var calendarView: TCCalendarView!
    
    var startDate: NSDate?
    var endDate: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()

        TCCalendarMonthTitleView.appearance().setTitleFont(UIFont.boldSystemFontOfSize(20))

        calendarView.fromDate = NSDate()
        calendarView.toDate = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 180)

        let headerLabel = UILabel(frame: CGRectMake(0.0, 0.0, 0.0, 100.0))
        headerLabel.font = UIFont.italicSystemFontOfSize(UIFont.systemFontSize())
        headerLabel.text = "Calendar Header"
        calendarView.headerView = headerLabel

        let footerLabel = UILabel(frame: CGRectMake(0.0, 0.0, 0.0, 50.0))
        footerLabel.font = UIFont.italicSystemFontOfSize(UIFont.systemFontSize())
        footerLabel.text = "Calendar Footer"
        calendarView.footerView = footerLabel

        calendarView.cellDecorateClosure = { cell, isEnabled in
            if !isEnabled {
                cell.dayLabel.textColor = UIColor.lightGrayColor()
                return
            }
            
            var color: UIColor = UIColor.clearColor()
            
            if let startDate = self.startDate {
                if cell.date == startDate {
                    color = UIColor.orangeColor()
                }

                if let endDate = self.endDate {
                    if cell.date == endDate {
                        if startDate == endDate {
                            color = UIColor.purpleColor()
                        } else {
                            color = UIColor.blueColor()
                        }
                    } else if cell.date.compare(startDate) == .OrderedDescending && cell.date.compare(endDate) == .OrderedAscending {
                        color = UIColor.grayColor()
                    }
                }
            }
            
            let view = UIView(frame: cell.bounds)
            view.backgroundColor = color
            cell.backgroundView = view
            
            cell.dayLabel.textColor = UIColor.blackColor()
        }

        calendarView.shouldEnableDateClosure = { date, calendar in
            return date.compareWithoutTime(NSDate(), inCalendar: calendar) != NSComparisonResult.OrderedAscending
        }
//
//        calendarView.shouldSelectDateClosure = { date, calendar in
//            return date.compareWithoutTime(NSDate(), inCalendar: calendar) != NSComparisonResult.OrderedSame
//        }
        
        calendarView.didSelectDateClosure = { date, calendar in
            if let startDate = self.startDate {
                if self.endDate == nil {
                    if date.compareWithoutTime(startDate, inCalendar: calendar) == NSComparisonResult.OrderedAscending {
                        self.startDate = date
                    } else {
                        self.endDate = date
                    }
                } else {
                    self.startDate = date
                    self.endDate = nil
                }
            } else {
                self.startDate = date
            }
            
            self.calendarView.reloadData()
        }
    }
}