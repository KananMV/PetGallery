//
//  HomeViewModel.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import Foundation

class HomeViewModel {
    var dogs: [Dog] = []
    var cats: [Cat] = []
    
    var success: (() -> Void)?
    var error: ((Error) -> Void)?
    
    func fetchDogs() {
        DogNetworkService.shared.getDogs { [weak self] result in
            switch result {
            case .success(let breeds):
                self?.dogs = breeds
                DispatchQueue.main.async {
                    self?.success?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error?(error)
                }
            }
        }
    }
    func fetchCats() {
        CatNetworkService.shared.getCats { [weak self] result in
            switch result {
            case .success(let cats):
                self?.cats = cats
                DispatchQueue.main.async {
                    self?.success?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error?(error)
                }
            }
        }
    }
}
