//
//  TCCalendarLayout.swift
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

class TCCalendarLayout: UICollectionViewFlowLayout {
    var backgroundViewReferenceSize: CGSize!

    func initialize() {
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0.0
        self.headerReferenceSize = CGSizeMake(0.0, 44.0)
        self.footerReferenceSize = CGSizeZero
        self.backgroundViewReferenceSize = CGSizeMake(0.0, 130.0)
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElementsInRect(rect)!
        let calendarView = self.collectionView as! TCCalendarView

        var sections = Set<UICollectionViewLayoutAttributes>()
        for attribute in attributes {
            if attribute.representedElementCategory == .SupplementaryView && attribute.representedElementKind == UICollectionElementKindSectionHeader {
                guard calendarView.sections[attribute.indexPath.section].hasDecorationView else { continue }

                sections.insert(attribute)
            }
        }

        for attribute in sections {
            let indexPath = attribute.indexPath

            guard calendarView.sections[indexPath.section].hasDecorationView else { continue }

            let bgAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: TCCalendarViewSectionBackgroundKind, withIndexPath: indexPath)

            let bgWidth = self.backgroundViewReferenceSize.width == 0 ? self.collectionView!.frame.width : self.backgroundViewReferenceSize.width
            let bgHeight = self.backgroundViewReferenceSize.height
            
            bgAttribute.frame = CGRectMake(0.0, attribute.frame.origin.y + attribute.frame.height, bgWidth, bgHeight)
            bgAttribute.zIndex = -10

            attributes.append(bgAttribute)
        }

        return attributes
    }

    override init() {
        super.init()

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }
}