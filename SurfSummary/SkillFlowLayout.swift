//
//  Row.swift
//  SurfSummary
//
//  Created by Данила Дорохов on 01.08.2023.
//

import Foundation
import UIKit

class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func skillLayout(collectionViewWidth: CGFloat) {
        let padding = 16
        var offset = padding
        for attribute in attributes {
            if(attribute.representedElementKind == nil){
                attribute.frame.origin.x = CGFloat(offset)
                offset += Int(attribute.frame.width + spacing)
            }
        }
    }
}

class SkillFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [Row]()
        var currentRowY: CGFloat = -1
        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 12))
            }
            rows.last?.add(attribute: attribute)
        }

        rows.forEach {
            $0.skillLayout(collectionViewWidth: collectionView?.frame.width ?? 0)
        }
        return rows.flatMap { $0.attributes }
    }
}
