//
//  HeaderImageTableViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 22.09.25.
//

import UIKit
import SnapKit

class HeaderImageTableViewCell: UITableViewHeaderFooterView {
    private let petImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let curveImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "curveImage")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        petImage.makeBottomRounded(curveDepth: 80)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(petImage)
        contentView.addSubview(curveImage)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        setCons()
    }
    
    private func setCons() {
        petImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        curveImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalToSuperview()
        }
    }
    
    func configure(image: String) {
        petImage.image = UIImage(named: image)
    }
}
