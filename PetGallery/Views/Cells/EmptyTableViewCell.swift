//
//  EmptyTableViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 22.09.25.
//

import UIKit
import SnapKit

class EmptyTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
