//
//  CollectionReusableViewFooter.swift
//  SurfSummary
//
//  Created by Данила Дорохов on 01.08.2023.
//

import UIKit

class CollectionReusableViewFooter: UICollectionReusableView {
    static let reuseIdentifier = "reusableViewFooter"

    @IBOutlet weak var mainStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
