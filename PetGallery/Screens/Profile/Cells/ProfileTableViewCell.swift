//
//  ProfileTableViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 26.09.25.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    enum ImageColor {
        case red
        case blue
        var uiColor: UIColor {
            switch self {
            case .red: return .red
            case .blue: return .black
            }
        }
    }
    
    enum ImageIcon {
        case email
        case logout
        var icon: UIImage {
            switch self {
            case .email: return UIImage(systemName: "envelope.fill") ?? UIImage()
            case .logout: return UIImage(systemName: "rectangle.portrait.and.arrow.forward.fill") ?? UIImage()
            }
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        let text = UserDefaultsManager.shared.getDataString(key: .email)
        label.text = text
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(emailLabel)
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(stackView)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureUI(imageIcon: ImageIcon, title: String, isEmailTextEnabled: Bool, tintColor: ImageColor) {
        iconImageView.image = imageIcon.icon
        iconImageView.tintColor = tintColor.uiColor
        titleLabel.text = title
        titleLabel.textColor = tintColor.uiColor
        emailLabel.isHidden = !isEmailTextEnabled
    }
}
