//
//  TCCalendarLayout.swift
//  TCCalendar
//
//  Created by Cyril Wei on 4/11/15.
//  Copyright (c) 2015 Cyril Wei. All rights reserved.
//

import UIKit

class TCCalendarLayout: UICollectionViewFlowLayout {

    func initialize() {
        self.sectionInset = UIEdgeInsetsZero
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0.0
        self.headerReferenceSize = CGSizeMake(0.0, 44.0)
        self.footerReferenceSize = CGSizeZero
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]

        var sections = NSMutableSet()
        for attribute in attributes {
            if attribute.representedElementCategory == .SupplementaryView && attribute.representedElementKind == UICollectionElementKindSectionHeader {
                sections.addObject(attribute)
            }
        }

        for attribute in sections {
            let bgAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: TCCalendarViewSectionBackgroundKind, withIndexPath: (attribute as! UICollectionViewLayoutAttributes).indexPath)

            bgAttribute.frame = CGRectMake(0.0, attribute.frame.origin.y + attribute.frame.height, self.collectionView!.frame.width, 100.0)
            bgAttribute.zIndex = attribute.zIndex - 1

            attributes.append(bgAttribute)
        }

        return attributes
    }

    override init() {
        super.init()

        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }
}