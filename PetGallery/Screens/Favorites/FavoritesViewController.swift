//
//  FavoritesViewController.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 29.09.25.
//

import UIKit
import Lottie

class FavoritesViewController: UIViewController {
    
    let viewModel = FavoritesViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        if let customFont = UIFont(name: "JosefinSans-Regular", size: 24) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 24)
        }
        let text = "PetGallery"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 3))
        attributedText.addAttribute(.foregroundColor, value: UIColor.acento, range: NSRange(location: 3, length: 7))
        
        label.attributedText = attributedText
        return label
    }()
    
    private lazy var loadingView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "Loading.json")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        view.dataSource = self
        view.delegate = self
        view.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
        view.backgroundColor = .systemGray6
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoritesData()
    }
    
    private func fetchFavoritesData() {
        loadingView.isHidden = false
        loadingView.play()
        collectionView.isHidden = true
        
        viewModel.fetchFavorites {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.loadingView.stop()
                    self.loadingView.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(loadingView)
        navigationItem.titleView = titleLabel
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell else { return UICollectionViewCell() }
        let pet = viewModel.pets[indexPath.row]
        
        switch pet {
        case .dog(let dog):
            cell.configure(with: dog)
        case .cat(let cat):
            cell.configure(with: cat)
        }
        
        cell.onHeartToggle = { isLiked, id in
            if !isLiked {
                CoreDataService.shared.deleteItemById(id: id)
                if let index = self.viewModel.pets.firstIndex(where: {
                    switch $0 {
                    case .dog(let dog): return String(dog.id) == id
                    case .cat(let cat): return cat.id == id
                    }
                }) {
                    self.viewModel.pets.remove(at: index)
                    self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 16
        let width = collectionView.frame.width - (inset * 2)
        let height = width * 0.3
        
        return CGSize(width: width, height: height)
    }
}
