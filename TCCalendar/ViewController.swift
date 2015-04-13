//
//  ViewController.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/11/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var calendarView: TCCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.shouldEnableDateClosure = { date, calendar in
            return date.compareWithoutTime(NSDate(), inCalendar: calendar) != NSComparisonResult.OrderedAscending
        }
//
//        calendarView.shouldSelectDateClosure = { date, calendar in
//            return date.compareWithoutTime(NSDate(), inCalendar: calendar) != NSComparisonResult.OrderedSame
//        }
    }
}