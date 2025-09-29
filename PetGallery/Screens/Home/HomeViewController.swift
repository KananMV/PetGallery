//
//  HomeViewController.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 26.09.25.
//

import UIKit

class HomeViewController: UIViewController, DogsCollectionViewCellDelegate, CatsCollectionViewCellDelegate {
    func catsCollectionViewCell(_ cell: CatsCollectionViewCell, didselectCat cat: Cat) {
        let detailVC = DetailsViewController()
        detailVC.configure(with: cat)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func dogsCollectionViewCell(_ cell: DogsCollectionViewCell, didSelectDog dog: Dog) {
        let detailVC = DetailsViewController()
        detailVC.configure(with: dog)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    private let viewModel = HomeViewModel()
    
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        view.dataSource = self
        view.delegate = self
        view.register(DogsCollectionViewCell.self, forCellWithReuseIdentifier: "DogsCollectionViewCell")
        view.register(CatsCollectionViewCell.self, forCellWithReuseIdentifier: "CatsCollectionViewCell")
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        viewModel.fetchDogs()
        viewModel.fetchCats()
        
        viewModel.success = {
            self.collectionView.reloadData()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = titleLabel
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    

}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogsCollectionViewCell", for: indexPath) as? DogsCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(with: viewModel.dogs)
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatsCollectionViewCell", for: indexPath) as? CatsCollectionViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            cell.configure(with: viewModel.cats)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = width * 0.75
        
        return CGSize(width: width, height: height)
    }
}
