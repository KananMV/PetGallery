//
//  DogsCollectionViewCell.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import UIKit

protocol CatsCollectionViewCellDelegate: AnyObject {
    func catsCollectionViewCell (_ cell: CatsCollectionViewCell, didselectCat cat: Cat )
}

class CatsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CatsCollectionViewCellDelegate?
    
    private let catLabel: UILabel = {
        let label = UILabel()
        label.text = "Cats"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24,weight: .semibold)
        return label
    }()
    
    private lazy var catIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "blueColorForUI")
        view.layer.cornerRadius = 28
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.addSubview(catLabel)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        view.dataSource = self
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.register(PetInfoCell.self, forCellWithReuseIdentifier: "PetInfoCell")
        view.backgroundColor = .clear
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cats: [Cat] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func configure(with cats: [Cat]) {
        self.cats = cats
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(catIndicatorView)
        contentView.addSubview(collectionView)
        print(cats.count)
        
        catLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        catIndicatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(54)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(catIndicatorView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}

extension CatsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetInfoCell", for: indexPath) as? PetInfoCell else { return UICollectionViewCell() }
        
        let cat = cats[indexPath.item]
        cell.configure(with: cat)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 * 3
        let availableWidth = collectionView.frame.width - padding
        let width = availableWidth / 2.5
        let height = width * 1.7
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCat = cats[indexPath.item]
        delegate?.catsCollectionViewCell(self, didselectCat: selectedCat)
    }
}
