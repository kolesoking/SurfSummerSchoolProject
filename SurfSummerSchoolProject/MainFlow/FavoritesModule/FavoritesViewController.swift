//
//  FavoritesViewController.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 03.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let failedText = "По этому запросу нет рузультатов"
        static let failedTextColor = UIColor(red: 0xB0 / 255, green: 0xB0 / 255, blue: 0xB0 / 255, alpha: 1)
    }
    
    // MARK: - Private Properties
    
    private let favoriteService = FavoriteService.shared
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var failedImage: UIImageView!
    @IBOutlet weak var failedLabel: UILabel!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confiureAppearance()
//        checkArrayForItems()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        checkArrayForItems()
        collectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension FavoritesViewController {
    
    func confiureAppearance() {
        collectionView.register(UINib(nibName: "\(FavoriteItemTableViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FavoriteItemTableViewCell.self)")
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 24, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        failedLabel.text = Constants.failedText
        failedLabel.font = .systemFont(ofSize: 14)
        failedLabel.textAlignment = .center
        failedLabel.textColor = Constants.failedTextColor
        failedLabel.numberOfLines = 0
        failedLabel.isHidden = true
        
        failedImage.isHidden = true
    }
    
//    func addPostsInArray() {
//
//        if favoritePosts.isEmpty == true {
//            favoritePosts = favoriteService.favoritePosts
//        }
//    }
    
//    func checkArrayForItems() {
//        if favoriteService.favoritePosts.isEmpty == true {
//            toggleHiddenViews([
//                collectionView,
//                failedImage,
//                failedLabel
//            ])
//        } else {
//            toggleHiddenViews([
//                collectionView,
//                failedImage,
//                failedLabel
//            ])
//        }
//    }
    
    func toggleHiddenViews(_ views: [UIView?]) {
        for view in views {
            guard let view = view else {
                return
            }
            view.isHidden.toggle()
        }
    }
    
}

// MARK: - UICollection

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteService.favoritePosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteItemTableViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteItemTableViewCell {
            var post = favoriteService.favoritePosts[indexPath.row]
            cell.imageURLString = post.imageURLInString
            cell.titleText = post.title
            cell.dateText = post.dateCreation
            cell.contentText = post.content
            cell.isFavorite = post.isFavorite
            
            cell.didFavoriteTapped = {
                post.isFavorite.toggle()
                
                self.favoriteService.deliteFromFavorite(indexPath: indexPath.row)
                self.collectionView.reloadData()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 16 * 2, height: 398)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.post = favoriteService.favoritePosts[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


