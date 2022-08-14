//
//  FavoritesViewController.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 03.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let model: MainModel = .init()
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confiureAppearance()
        configoreModel()
        model.loadPosts()
    }
}

// MARK: - Private Methods

private extension FavoritesViewController {
    
    func confiureAppearance() {
        collectionView.register(UINib(nibName: "\(FavoriteItemTableViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FavoriteItemTableViewCell.self)")
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 24, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configoreModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
}

// MARK: - UICollection

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteItemTableViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteItemTableViewCell {
            let item = model.items[indexPath.row]
            cell.imageURLString = item.imageURLInString
            cell.titleText = item.title
            cell.dateText = item.dateCreation
            cell.contentText = item.content
            cell.isFavorite = item.isFavorite
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
        vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


