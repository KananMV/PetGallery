//
//  FooterIMageTableViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 22.09.25.
//

import UIKit
import SnapKit

class FooterImageTableViewCell: UITableViewHeaderFooterView {
    
    private let bottomCurveImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "curveImage2")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bottomCurveImage)
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
        bottomCurveImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
