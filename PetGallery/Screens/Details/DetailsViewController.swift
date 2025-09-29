//
//  DetailsViewController.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 29.09.25.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        view.addArrangedSubview(nameLabel)
        view.addArrangedSubview(subStackView)
        view.addArrangedSubview(aboutTextLabel)
        view.addArrangedSubview(aboutLabel)
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = .dogIcon
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .acento
        label.font = .systemFont(ofSize: 20,weight: .semibold)
        return label
    }()
    
    private lazy var heightView: UIView = {
        let view = UIView()
        view.addSubview(heightLabel)
        view.backgroundColor = UIColor(named: "detalisVCViewColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var weightView: UIView = {
        let view = UIView()
        view.addSubview(weightLabel)
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "detalisVCViewColor")
        return view
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lifeSpanView: UIView = {
        let view = UIView()
        view.addSubview(lifeSpanLabel)
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "detalisVCViewColor")
        
        return view
    }()
    
    private let lifeSpanLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let aboutTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .acento
        label.font = .systemFont(ofSize: 16,weight: .semibold)
        return label
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(heightView)
        view.addArrangedSubview(weightView)
        view.addArrangedSubview(lifeSpanView)
        view.spacing = 20
        view.distribution = .equalSpacing
        view.alignment = .center
        view.axis = .horizontal
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(imageView)
        setCons()
    }
    
    func setCons() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().dividedBy(2.2)
        }
    
        
        heightLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        weightLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        lifeSpanLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        subStackView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        heightView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(heightView.snp.height)
        }
        
        weightView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(heightView.snp.height)
        }
        
        lifeSpanView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(heightView.snp.height)
        }
    }
    func configure(with dog: Dog) {
        nameLabel.text = dog.name
        heightLabel.text = "Height\n\(dog.height.metric ?? "") sm"
        weightLabel.text = "Weight\n\(dog.weight.metric ?? "") kg"
        lifeSpanLabel.text = "Life span\n\(dog.lifeSpan ?? "")"
        aboutTextLabel.text = "Information about \(dog.name)"
        let attributedString = NSMutableAttributedString()
        attributedString.append("Origin: ".colored(.red, font: .systemFont(ofSize: 16, weight: .semibold)))
        attributedString.append("\(dog.origin ?? "Unknown")\n".colored(.black, font: .systemFont(ofSize: 16, weight: .regular)))
        attributedString.append("Temperament: ".colored(.red, font: .systemFont(ofSize: 16, weight: .semibold)))
        attributedString.append("\(dog.temperament ?? "Unknown")".colored(.black, font: .systemFont(ofSize: 16, weight: .regular)))

        aboutLabel.attributedText = attributedString
        aboutLabel.numberOfLines = 0
        aboutLabel.lineBreakMode = .byWordWrapping
        
        
        if let imageUrlString = dog.image?.url, let url = URL(string: imageUrlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "dogIcon"))
        } else {
            imageView.image = UIImage(named: "dogIcon")
        }
    }
    
    func configure(with cat: Cat) {
        nameLabel.text = cat.name
        heightLabel.text = "Height\n 30 sm"
        weightLabel.text = "Weight\n\(cat.weight.metric ?? "") kg"
        lifeSpanLabel.text = "Life span\n\(cat.lifeSpan ?? "")\n years"
        aboutTextLabel.text = "Information about \(cat.name)"
        
        aboutLabel.text = cat.description
        aboutLabel.font = .systemFont(ofSize: 16)
        
        if let imageUrlString = cat.image?.url, let url = URL(string: imageUrlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "catIcon"))
        } else {
            imageView.image = UIImage(named: "catIcon")
        }
        
    }
    
    
}
