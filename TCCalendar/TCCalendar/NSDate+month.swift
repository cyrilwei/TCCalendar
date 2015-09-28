//
//  NSDate+month.swift
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

extension NSDate {
    func firstDateOfMonth(inCalendar calendar: NSCalendar) -> NSDate {
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)

        components.day = 1

        return calendar.dateFromComponents(components)!
    }

    func lastDateOfMonth(inCalendar calendar: NSCalendar) -> NSDate {
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)

        components.day = 0
        components.month += 1

        return calendar.dateFromComponents(components)!
    }

    func daysOfMonth(inCalendar calendar: NSCalendar) -> Int {
        let components = calendar.components(.Day, fromDate: self.firstDateOfMonth(inCalendar: calendar), toDate: self.lastDateOfMonth(inCalendar: calendar), options: [])

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
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)
        let anotherComponents = calendar.components([.Year, .Month, .Day], fromDate: anotherDate)

        let dateOnly = calendar.dateFromComponents(components)!
        let anotherDateOnly = calendar.dateFromComponents(anotherComponents)!

        return dateOnly.compare(anotherDateOnly)
    }
}