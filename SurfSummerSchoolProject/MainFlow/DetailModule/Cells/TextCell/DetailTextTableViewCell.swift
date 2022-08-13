//
//  TextTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import UIKit

class DetailTextTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Properties
    
    var text: String = "" {
        didSet {
            contentLabel.text = text
        }
    }
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configurationAppearance()
    }
    
    // MARK: - Private Methods
    
    private func configurationAppearance() {
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
    }
}
