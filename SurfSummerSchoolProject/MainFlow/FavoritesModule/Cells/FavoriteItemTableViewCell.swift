//
//  FavoriteItemTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 08.08.2022.
//

import UIKit

class FavoriteItemTableViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let heartImage = UIImage(named: "heart")
        static let fillHeartImage = UIImage(named: "fillHeart")
    }
    
    // MARK: - Views
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Events
    
    var didFavoriteTapped: (() -> Void)?
    
    // MARK: - Colculate
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            mainImageView.image = image
        }
    }
    
    var titleText = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var dateText = "" {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    var contentText = "" {
        didSet {
            contentLabel.text = contentText
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: Any) {
        didFavoriteTapped?()
        isFavorite.toggle()
    }
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }
}

// MARK: - Private Methods

private extension FavoriteItemTableViewCell {
    
    func configureApperance() {
        
        mainImageView.layer.cornerRadius = 12
        mainImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16)
        
        dateLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        dateLabel.font = .systemFont(ofSize: 10)
        
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 12)
        
        favoriteButton.tintColor = .white
    }
}
