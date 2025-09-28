//
//  RegisterViewController.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 23.09.25.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero,style: .grouped)
        view.register(HeaderImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: "HeaderImageTableViewCell")
        view.register(FooterImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: "FooterImageTableViewCell")
        view.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        view.register(RegisterTableViewCell.self, forCellReuseIdentifier: "RegisterTableViewCell")
        
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

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as? RegisterTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.loginButtonAction = {
                let loginVC = LoginViewController()
                let entryVC = EntryViewController()
                self.navigationController?.setViewControllers([entryVC,loginVC], animated: true)
            }
            cell.registerButtonAction = { email, password, confirmPassword in
                if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                    self.showAlert(title: "Error", message: "Please fill all fields")
                } else if password != confirmPassword {
                    self.showAlert(title: "Error", message: "Passwords do not match")
                } else if !email.isValidEmail {
                    self.showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
                } else {
                    JsonFileManager.shared.readUserDataFromFile { users in
                        if users.contains(where: { $0.email.lowercased() == email.lowercased() }) {
                            self.showAlert(title: "Error", message: "This email is already registered")
                            return
                        }
                        var updatedUsers = users
                        let newUser = User(email: email, passwword: password)
                        updatedUsers.append(newUser)
                        JsonFileManager.shared.saveDataToFile(users: updatedUsers)
                        let alert = UIAlertController(title: "Success", message: "User registered successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            let loginVC = LoginViewController(prefilledEmail: email)
                            self.navigationController?.pushViewController(loginVC, animated: true)
                        }))
                        self.present(alert, animated: true)
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
            let estimatedNormalCellHeight: CGFloat = 300
            let totalContent = headerHeight + estimatedNormalCellHeight + footerHeight
            let emptyHeight = max(view.frame.height - totalContent, 40)
            print(emptyHeight)
            return emptyHeight
        }
    }
}
