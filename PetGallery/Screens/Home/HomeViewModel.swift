//
//  HomeViewModel.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import Foundation

class HomeViewModel {
    var breeds: [Breed] = []
    
    var success: (() -> Void)?
    var error: ((Error) -> Void)?
    
    func fetchDogs() {
        DogNetworkService.shared.getBreeds { [weak self] result in
            switch result {
            case .success(let breeds):
                self?.breeds = breeds
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
