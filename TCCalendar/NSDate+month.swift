//
//  NSDate+month.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/12/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
//

import UIKit

extension NSDate {
    func firstDateOfMonth(inCalendar calendar: NSCalendar) -> NSDate {
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)

        components.day = 1

        return calendar.dateFromComponents(components)!
    }

    func lastDateOfMonth(inCalendar calendar: NSCalendar) -> NSDate {
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)

        components.day = 0
        components.month += 1

        return calendar.dateFromComponents(components)!
    }

    func daysOfMonth(inCalendar calendar: NSCalendar) -> Int {
        let components = calendar.components(.CalendarUnitDay, fromDate: self.firstDateOfMonth(inCalendar: calendar), toDate: self.lastDateOfMonth(inCalendar: calendar), options: .allZeros)

        return components.day + 1
    }

    var longMonthString: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.stringFromDate(self)
    }

    var shortMonthString: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.stringFromDate(self)
    }

    func compareWithoutTime(anotherDate: NSDate, inCalendar calendar: NSCalendar) -> NSComparisonResult {
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        let anotherComponents = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: anotherDate)

        let dateOnly = calendar.dateFromComponents(components)!
        let anotherDateOnly = calendar.dateFromComponents(anotherComponents)!

        return dateOnly.compare(anotherDateOnly)
    }
}