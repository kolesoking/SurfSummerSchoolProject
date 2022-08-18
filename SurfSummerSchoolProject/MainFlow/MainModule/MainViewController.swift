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
        
        static let failedText = "Не удалось загрузить ленту \nОбновите экран или попробуйте позже"
        static let failedTextColor = UIColor(red: 0xB0 / 255, green: 0xB0 / 255, blue: 0xB0 / 255, alpha: 1)
        
        static let failedButtonTextLable = "Обновить"
    }
    
    // MARK: - Private Properties
    
    private let favoriteService = FavoriteService.shared
    
    private let model: MainModel = .init()
    private var posts: [DetailItemModel] = []
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var failedImage: UIImageView!
    @IBOutlet weak var failedLabel: UILabel!
    @IBOutlet weak var failedButton: UIButton!
    
    // MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configureModel()
        model.loadPosts()
        checkArrayForItems()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "searchNav"),
            style: .plain,
            target: self,
            action: #selector(goToSearchVC)
        )
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func actionFailedButton(_ sender: Any) {
        if model.items.isEmpty != true {
            viewDidLoad()
            toggleHiddenViews([
                collectionView,
                failedImage,
                failedLabel,
                failedButton
            ])
        }
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        failedImage.isHidden = true
        
        failedLabel.text = Constants.failedText
        failedLabel.font = .systemFont(ofSize: 14)
        failedLabel.textAlignment = .center
        failedLabel.textColor = Constants.failedTextColor
        failedLabel.numberOfLines = 0
        failedLabel.isHidden = true
        
        failedButton.backgroundColor = .black
        failedButton.tintColor = .white
        failedButton.titleLabel?.font = .systemFont(ofSize: 16)
        failedButton.isHidden = true
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    func checkArrayForItems() {
        if model.items.isEmpty == true {
            toggleHiddenViews([
                collectionView,
                failedImage,
                failedLabel,
                failedButton
            ])
            activityIndicator.stopAnimating()
        }
    }
    
    func toggleHiddenViews(_ views: [UIView?]) {
        for view in views {
            guard let view = view else {
                return
            }

            view.isHidden.toggle()
        }
    }
    
    func checkingFavorites(imageURLInString: String) -> Bool {
        
        var isFavorite: Bool = false
        
        for post in FavoriteService.shared.favoritePosts {
            if post.imageURLInString == imageURLInString {
                isFavorite = true
            }
        }
        
        return isFavorite
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
            var item = model.items[indexPath.row]
            cell.imageURLString = item.imageURLInString
            cell.title = item.title
            cell.isFavorite = checkingFavorites(imageURLInString: item.imageURLInString)
            
            cell.didFavoritesTapped = {
                
                item.isFavorite.toggle()
                self.favoriteService.saveInFavorites(post: item)
            }
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
        vc.post = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
