

import UIKit
import SnapKit

class RegisterTableViewCell: UITableViewCell {
    
    var loginButtonAction: (() -> Void)?
    var registerButtonAction: ((String, String, String) -> Void)?
    
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
        text.autocapitalizationType = .none
        text.textAlignment = .left
        let placeholderText = "Email"
        text.keyboardType = .emailAddress
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
        
        return text
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 18
        text.layer.borderWidth = 1
        text.textAlignment = .left
        text.layer.masksToBounds = true
        let placeholderText = "Confrim Password"
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
        
        return text
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .acento
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        let title = "Login"
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.red,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(loginLabel)
        view.addArrangedSubview(loginButton)
        view.axis = .horizontal
        view.spacing = 4
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
        contentView.addSubview(label)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmPasswordTextField)
        contentView.addSubview(signUpButton)
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
            make.height.equalTo(emailTextField)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(emailTextField)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(40)
            make.leading.equalTo(confirmPasswordTextField.snp.leading)
            make.trailing.equalTo(confirmPasswordTextField.snp.trailing)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func loginButtonTapped() {
        loginButtonAction?()
    }
    
    
    @objc private func signUpButtonTapped() {
        guard let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text else {
            return
        }
        registerButtonAction?(email, password, confirmPassword)
        
    }
    
    
    
}
