//
//  FavoritesCollectionViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 30.09.25.
//

import UIKit
import Kingfisher
class FavoritesCollectionViewCell: UICollectionViewCell {
    
    var onHeartToggle: ((Bool, String) -> Void)?
    
    private var isLiked = false
    private var currentPetId: String!
    
    private let petImage: UIImageView = {
        let image = UIImageView()
        image.image = .dogIcon
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    private let petName: UILabel = {
        let label = UILabel()
        label.text = "Bulldog"
        return label
    }()
    
    private lazy var heartView: UIView = {
        let view = UIView()
        view.addSubview(heartImage)
        view.backgroundColor = UIColor(named: "detalisVCViewColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleHeart))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private let heartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        image.contentMode = .scaleAspectFit
        image.tintColor = .darkGray
        return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(petImage)
        contentView.addSubview(heartView)
        contentView.addSubview(petName)
        
        petImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(petImage.snp.height)
        }
        
        heartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.width.height.equalTo(40)
        }
        
        heartImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        petName.snp.makeConstraints { make in
            make.left.equalTo(petImage.snp.right).offset(20)
            make.top.equalTo(petImage.snp.top).offset(12)
            make.right.lessThanOrEqualTo(heartView.snp.left).offset(-8)
        }
    }
    
    @objc private func toggleHeart() {
        isLiked.toggle()
        
        if isLiked {
            heartImage.image = UIImage(systemName: "heart.fill")
            heartImage.tintColor = .systemRed
        } else {
            heartImage.image = UIImage(systemName: "heart")
            heartImage.tintColor = .darkGray
        }
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.heartView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.heartView.transform = .identity
            }
        })
        onHeartToggle?(isLiked, currentPetId)
    }
    
    func configure(with dog: Dog, isLiked: Bool = true) {
        petName.text = dog.name
        currentPetId = String(dog.id)
        if let imageId = dog.referenceImageID,
           let url = URL(string: "https://cdn2.thedogapi.com/images/\(imageId).jpg") {
            petImage.kf.setImage(with: url, placeholder: UIImage.dogIcon)
        } else {
            petImage.image = .dogIcon
        }
        
        self.isLiked = isLiked
        heartImage.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartImage.tintColor = isLiked ? .systemRed : .darkGray
    }
    
    func configure(with cat: Cat, isLiked: Bool = true) {
        currentPetId = cat.id
        petName.text = cat.name
        
        if let imageId = cat.referenceImageID,
           let url = URL(string: "https://cdn2.thecatapi.com/images/\(imageId).jpg") {
            petImage.kf.setImage(with: url, placeholder: UIImage.catIcon)
        } else {
            petImage.image = .catIcon
        }
        
        self.isLiked = isLiked
        heartImage.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartImage.tintColor = isLiked ? .systemRed : .darkGray
    }
    
    
    
    
}
