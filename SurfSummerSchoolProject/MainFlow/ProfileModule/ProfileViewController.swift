//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Views
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var exitButton: UIButton!
    
    // MARK: - Properties
    
    let userInfo: UserInfo = UserInfo.getUserInfo()
    
    var imageURLInString: String = "" {
        didSet {
            guard let url = URL(string: imageURLInString) else { return }
            avatar.loadImage(from: url)
        }
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
    }
    
    // MARK: - Actions
    
    @IBAction func exitButtonPresed(_ sender: Any) {
        //TODO: - adding logic for exit Button
    }
}

// MARK: - Private Methods

private extension ProfileViewController {
    func configureAppearance() {
        configureTableview()
        
        avatar.layer.cornerRadius = 12
        avatar.contentMode = .scaleAspectFill
        
        fullNameLabel.font = .systemFont(ofSize: 18)
        fullNameLabel.text = userInfo.fullName
        fullNameLabel.numberOfLines = 0
        
        aboutLabel.font = .systemFont(ofSize: 12)
        aboutLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        aboutLabel.text = userInfo.about
        
        exitButton.backgroundColor = .black
        exitButton.titleLabel?.text = "Выйти"
        exitButton.titleLabel?.font = .systemFont(ofSize: 16)
        exitButton.titleLabel?.textColor = .white
        
        
        
        imageURLInString = userInfo.avatar
        
        
        
    }
    
    func configureTableview() {
        tableView.register(UINib(nibName: "\(ProfileTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ProfileTableViewCell.self)")
        
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileTableViewCell.self)")
        if let cell = cell as? ProfileTableViewCell {
            switch indexPath.row {
            case 0:
                cell.title = "Город"
                cell.subTitle = userInfo.city
            case 1:
                cell.title = "Телефон"
                cell.subTitle = userInfo.phone
                
            case 2:
                cell.title = "Почта"
                cell.subTitle = userInfo.email
            default:
                return UITableViewCell()
            }
        }
        return cell ?? UITableViewCell()
    }
    
    
    
    
}
