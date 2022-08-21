//
//  ProfileTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 21.08.2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabl: UILabel!
    
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subTitle: String = "" {
        didSet {
            subTitleLabl.text = subTitle
        }
    }
    
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAppearence()
    }
    
    // MARK: - Private Methods
    
    private func configureAppearence() {
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        
        subTitleLabl.font = .systemFont(ofSize: 18)
    }
}
