//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 06.08.2022.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Views
    
    private let tableView = UITableView()
    
    // MARK: - Properties
    
    var model: DetailItemModel?

    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

// MARK: - Private Methods

private extension DetailViewController {
    
    func configureAppearance() {
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = model?.title
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
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(UINib(nibName: "\(ImageTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(TitleTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(TitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(TextTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(TextTableViewCell.self)")
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)")
            if let cell = cell as? ImageTableViewCell {
                cell.image = model?.image
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleTableViewCell.self)")
            if let cell = cell as? TitleTableViewCell {
                cell.title = model?.title ?? ""
                cell.date = model?.dataCreation ?? ""
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextTableViewCell.self)")
            if let cell = cell as? TextTableViewCell {
                cell.text = model?.content ?? ""
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    
}
