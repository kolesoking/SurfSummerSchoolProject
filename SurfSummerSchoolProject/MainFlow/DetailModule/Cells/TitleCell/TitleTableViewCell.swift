//
//  TitleTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 06.08.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
        
    }
    
    // MARK: - Private Methods
    
    private func configureAppearence() {
        selectionStyle = .none
        titleLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
    }
}
