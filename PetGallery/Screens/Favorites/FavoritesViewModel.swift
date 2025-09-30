//
//  FavoritesViewModel.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 30.09.25.
//

import Foundation

enum PetType {
    case dog(Dog)
    case cat(Cat)
}

class FavoritesViewModel {
    var favoritesPetIds: [String] {
        CoreDataService.shared.fetchFavoriteIds()
    }
    
    var pets: [PetType] = []
    
    func fetchFavorites(completion: @escaping () -> Void) {
        pets.removeAll()
        
        for id in favoritesPetIds {
            DogNetworkService.shared.getDogById(id: id) { result in
                switch result {
                case .success(let dog):
                    self.pets.append(.dog(dog))
                case .failure:
                    CatNetworkService.shared.getCatById(id: id) { result in
                        switch result {
                        case .success(let cat):
                            self.pets.append(.cat(cat))
                        case .failure(let error):
                            print("Error:", error)
                        }
                        completion()
                    }
                }
                completion()
            }
        }
    }
}
