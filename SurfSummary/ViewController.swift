//
//  ViewController.swift
//  SurfSummary
//
//  Created by Данила Дорохов on 01.08.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var skills = [
        "Swift",
        "Kotlin",
        "Java",
        "Xcode",
        "Android Studio",
        "Firebase",
    ]
    var editSkills = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = SkillFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 44)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "CollectionReusableViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:CollectionReusableViewHeader.reuseIdentifier)
        collectionView.register(UINib(nibName: "CollectionReusableViewFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:CollectionReusableViewFooter.reuseIdentifier)
        self.collectionView.register(UINib(nibName: "CollectionViewSkillCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewSkillCell.reuseIdentifier)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewSkillCell.reuseIdentifier, for: indexPath) as! CollectionViewSkillCell
        let requiredWidth = collectionView.bounds.size.width
        let targetSize = CGSize(width: requiredWidth, height: 0)
        cell.skillLabel.text = skills[indexPath.row]
        let adequateSize = cell.preferredLayoutSizeFittingSize(targetSize: targetSize)
        return adequateSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewSkillCell.reuseIdentifier, for: indexPath) as! CollectionViewSkillCell
        cell.skillLabel.text = skills[indexPath.row]
        cell.skillLabel.preferredMaxLayoutWidth = collectionView.frame.width - (editSkills ? 110 : 80)
        cell.removeButton.isHidden = !editSkills
        if(editSkills && indexPath.row == skills.count - 1){
            cell.removeButton.isHidden = true
            cell.skillLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        }else{
            cell.skillLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        }
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(deleteSkill), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteSkill(sender:UIButton){
        skills.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(editSkills && indexPath.row == skills.count - 1){
            let alert = UIAlertController(title: "Добавление навыка", message: "Введите название навыка которым вы владеете", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Введите название"
            }
            alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { [weak alert] (_) in
                
            }))
            alert.addAction(UIAlertAction(title: "Добавить", style: .cancel, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                if(!textField.text!.isEmpty){
                    self.skills.insert(textField.text!, at: self.skills.count - 1)
                    self.collectionView.reloadData()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let header = Bundle.main.loadNibNamed("CollectionReusableViewHeader", owner: nil, options: nil)![0] as! CollectionReusableViewHeader
        return CGSize(width: self.view.frame.width, height: header.mainStackView.frame.height + 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let footer = Bundle.main.loadNibNamed("CollectionReusableViewFooter", owner: nil, options: nil)![0] as! CollectionReusableViewFooter
        return CGSize(width: self.view.frame.width, height: footer.mainStackView.frame.height + 32)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableViewHeader.reuseIdentifier, for: indexPath) as! CollectionReusableViewHeader
            header.editButton.addTarget(self, action: #selector(triggerEditMode), for: .touchUpInside)
            if (editSkills){
                header.editButton.setImage(UIImage(named: "icon_done"), for: .normal)
            }else{
                header.editButton.setImage(UIImage(named: "icon_edit"), for: .normal)
            }
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionReusableViewFooter.reuseIdentifier, for: indexPath) as! CollectionReusableViewFooter
            return footer
        }
    }
    
    @objc func triggerEditMode(sender:UIButton){
        editSkills.toggle()
        if(editSkills){
            skills.append("+")
        }else{
            skills.removeLast()
        }
        collectionView.reloadData()
    }
}


