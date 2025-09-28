//
//  PetInfoCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import UIKit
import Kingfisher

class PetInfoCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubview(petImage)
        view.addSubview(heartView)
        view.addSubview(stackView)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        return view
    }()
    
    private let petImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dogIcon")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var heartView: UIView = {
        let view = UIView()
        view.addSubview(heartImage)
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let heartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        image.contentMode = .scaleAspectFit
        image.tintColor = .darkGray
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pitbull"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let bredForLabel: UILabel = {
        let label = UILabel()
        label.text = "Hounting"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .textFieldBorder
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(nameLabel)
        view.addArrangedSubview(bredForLabel)
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        petImage.image = UIImage(named: "dogIcon")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        petImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.4)
        }
        
        heartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.height.equalTo(24)
        }
        
        heartImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(petImage.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            
        }
    }
    func configure(with breed: Breed) {
        nameLabel.text = breed.name
        let bredForText = (breed.bredFor?.isEmpty == false) ? breed.bredFor! : "Unknown"
        bredForLabel.text = bredForText
        
        if let imageUrlString = breed.image?.url, let url = URL(string: imageUrlString) {
            petImage.kf.setImage(with: url, placeholder: UIImage(named: "dogIcon"))
        } else {
            petImage.image = UIImage(named: "dogIcon")
        }
    }
}
