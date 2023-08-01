//
//  CollectionViewSkillCell.swift
//  SurfSummary
//
//  Created by Данила Дорохов on 01.08.2023.
//

import UIKit

class CollectionViewSkillCell: UICollectionViewCell {
    
    static let reuseIdentifier = "skillCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var mainStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 12
        removeButton.isHidden = false
        // Initialization code
    }
    
    func preferredLayoutSizeFittingSize(targetSize:CGSize) -> CGSize {
        let originalFrame = self.frame
        let originalPreferredMaxLayoutWidth = self.skillLabel.preferredMaxLayoutWidth
        var frame = self.frame
        frame.size = targetSize
        self.frame = frame
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.skillLabel.preferredMaxLayoutWidth = self.skillLabel.bounds.size.width
        let computedSize = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let newSize = CGSize(width:targetSize.width,height:computedSize.height)
        self.frame = originalFrame
        self.skillLabel.preferredMaxLayoutWidth = originalPreferredMaxLayoutWidth
        
        return newSize
    }
}
