//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 06.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate, UISearchResultsUpdating {
    
    // MARK: - Constants
    
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetwinElements: CGFloat = 7
        static let spaceBetwinRows: CGFloat = 8
        
        static let failedText = "Не удалось загрузить ленту \nОбновите экран или попробуйте позже"
        static let failedTextColor = UIColor(red: 0xB0 / 255, green: 0xB0 / 255, blue: 0xB0 / 255, alpha: 1)
        
        static let failedButtonTextLable = "Обновить"
    }
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Private properties
    
    var posts: [DetailItemModel] = []
    private var filtredPosts: [DetailItemModel] = []
    private let search = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        configureNavigationBar()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtredContentForSearchText(searchController.searchBar.text!)
    }
}

// MARK: - Private Methods

private extension SearchViewController {
    
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "backArrow"),
            style: .plain,
            target: navigationController,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureAppearence() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.layer.cornerRadius = CGFloat(22)
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
    }
    
    func filtredContentForSearchText(_ searchText: String) {
        
        filtredPosts = posts.filter { (post: DetailItemModel) -> Bool in
            return post.title.lowercased().contains(searchText.lowercased())
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return filtredPosts.count
        }
        return posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            
            var post: DetailItemModel
            
            if isFiltering {
                post = filtredPosts[indexPath.row]
            } else {
                post = posts[indexPath.row]
            }
            
            cell.imageURLString = post.imageURLInString
            cell.isFavorite = post.isFavorite
            cell.title = post.title
            
            cell.didFavoritesTapped = {
                
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
        
        var post: DetailItemModel
        
        if isFiltering {
            post = filtredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }
        vc.post = post
        navigationController?.pushViewController(vc, animated: true)
    }


}
