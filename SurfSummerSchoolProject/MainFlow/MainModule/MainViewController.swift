//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 04.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetwinElements: CGFloat = 7
        static let spaceBetwinRows: CGFloat = 8
    }
    
    // MARK: - Private Properties
    
    private let model: MainModel = .init()
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configureModel()
        model.loadPosts()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "searchNav"),
            style: .plain,
            target: self,
            action: #selector(goToSearchVC)
        )
        navigationController?.navigationBar.tintColor = .black
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc func goToSearchVC() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
}

// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.imageURLString = item.imageURLInString
            cell.title = item.title
            cell.isFavorite = item.isFavorite
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horisontalInset * 2 - Constants.spaceBetwinElements) / 2
        return CGSize(width: itemWidth, height: 1.46 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetwinRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetwinElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
