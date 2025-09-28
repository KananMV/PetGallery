

import UIKit
import SnapKit

class LoginTableViewCell: UITableViewCell {
    
    
    
    var registerButtonAction: (() -> Void)?
    var loginButtonAction: ((String,String) -> Void)?
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Enter your details"
        label.textColor = .red
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 18
        text.layer.borderWidth = 1
        text.layer.masksToBounds = true
        text.textAlignment = .left
        text.keyboardType = .emailAddress
        text.autocapitalizationType = .none
        let placeholderText = "Email"
        text.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .foregroundColor: UIColor(named: "textFieldBorderColor") ?? .gray,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ]
        )
        
        text.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        text.leftView = paddingView
        text.leftViewMode = .always
        
        return text
    }()
    
    private let passwordTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 18
        text.layer.borderWidth = 1
        text.textAlignment = .left
        text.layer.masksToBounds = true
        let placeholderText = "Password"
        text.isSecureTextEntry = true
        text.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .foregroundColor: UIColor(named: "textFieldBorderColor") ?? .gray,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ]
        )
        text.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.rightView = paddingView
        text.rightViewMode = .always
        
        return text
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
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let title = "Sign up"
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.red,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(signUpLabel)
        view.addArrangedSubview(signUpButton)
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    func prefillEmail(_ email: String) {
        emailTextField.text = email
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        contentView.addSubview(stackView)
        setcons()
    }
    
    private func setcons() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    
    }
    
    @objc private func signUpButtonTapped() {
        registerButtonAction?()
    }
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        loginButtonAction?(email, password)
        
    }
    
    
    
}
