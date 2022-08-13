//
//  ImageTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            mainImageView.image = image
        }
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainImageView.layer.cornerRadius = 12
        mainImageView.contentMode = .scaleAspectFill
    }
}
