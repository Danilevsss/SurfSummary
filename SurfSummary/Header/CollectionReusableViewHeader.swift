//
//  CollectionReusableViewHeader.swift
//  SurfSummary
//
//  Created by Данила Дорохов on 01.08.2023.
//

import UIKit

class CollectionReusableViewHeader: UICollectionReusableView {
    static let reuseIdentifier = "reusableViewHeader"

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 2.0
        nameLabel.text = "Дорохов Данила\nИванович"
        // Initialization code
    }
    
}
