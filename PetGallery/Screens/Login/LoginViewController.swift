//
//  LoginViewController.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 23.09.25.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let prefilledEmail: String?
    
    init(prefilledEmail: String? = nil) {
        self.prefilledEmail = prefilledEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero,style: .grouped)
        view.register(HeaderImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: "HeaderImageTableViewCell")
        view.register(FooterImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: "FooterImageTableViewCell")
        view.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        view.register(LoginTableViewCell.self, forCellReuseIdentifier: "LoginTableViewCell")
        
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.contentInset = .zero
        view.scrollIndicatorInsets = .zero
        view.contentInsetAdjustmentBehavior = .never
        view.isScrollEnabled = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .red
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(backButton)
        navigationController?.navigationBar.isHidden = true
        tableView.bounces = false
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        setCons()
    }
    
    private func setCons() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(20)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

}

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderImageTableViewCell") as? HeaderImageTableViewCell else { return nil }
        header.configure(image: "catIcon")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.frame.width
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell") as? LoginTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if let email = prefilledEmail {
                cell.prefillEmail(email)
            }
            
            
            cell.registerButtonAction = {
                let vc = RegisterViewController()
                let entryVC = EntryViewController()
                self.navigationController?.setViewControllers([entryVC,vc], animated: true)
            }
            
            cell.loginButtonAction = { email, password in
                if email.isEmpty || password.isEmpty {
                    self.showAlert(title: "Error", message: "Fill all fields")
                } else if !email.isValidEmail {
                    self.showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
                } else {
                    JsonFileManager.shared.readUserDataFromFile { users in
                        if let _ = users.first(where: { $0.email == email && $0.passwword == password }) {
                            UserDefaultsManager.shared.saveDataBool(value: true, key: .isLogedIn)
                            UserDefaultsManager.shared.saveDataString(value: email, key: .email)
                            NotificationCenter.default.post(name: .didLogin, object: nil)
                        } else {
                            self.showAlert(title: "Error", message: "Invalid email or password")
                        }
                    }
                }
                
                
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as? EmptyTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterImageTableViewCell") as? FooterImageTableViewCell else { return nil }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerHeight: CGFloat = view.frame.width
        let footerHeight: CGFloat = 100

        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else {
            let estimatedNormalCellHeight: CGFloat = 250
            let totalContent = headerHeight + estimatedNormalCellHeight + footerHeight
            let emptyHeight = max(view.frame.height - totalContent, 40)
            print(emptyHeight)
            return emptyHeight
        }
    }
    
    
}
