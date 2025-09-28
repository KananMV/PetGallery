//
//  EntryVCTableViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 22.09.25.
//

import UIKit
import SnapKit

class EntryVCTableViewCell: UITableViewCell {
    
    enum ActionType {
        case login
        case register
    }
    
    var buttonAction: ((ActionType) -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        if let customFont = UIFont(name: "JosefinSans-Regular", size: 48) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 48)
        }
        let text = "PetGallery"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 3))
        attributedText.addAttribute(.foregroundColor, value: UIColor.acento, range: NSRange(location: 3, length: 7))

        label.attributedText = attributedText
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "Welcome!"
        return label
    }()
    
    private let buttonSelectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in or register to adopt \n your new furry friend.!"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .acento
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.acento, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.acento.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var labelstackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        view.addArrangedSubview(welcomeLabel)
        view.addArrangedSubview(buttonSelectionLabel)
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.addArrangedSubview(loginButton)
        view.addArrangedSubview(registerButton)
        return view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelstackView)
        contentView.addSubview(buttonStackView)
        
        setCons()
    }
    
    private func setCons() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        labelstackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(labelstackView.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    @objc private func loginButtonTapped() {
        buttonAction?(.login)
    }
    
    @objc private func registerButtonTapped() {
        buttonAction?(.register)
    }
}
