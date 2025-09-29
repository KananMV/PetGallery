//
//  DogModel.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import Foundation

struct Dog: Codable {
    let weight: Weight
    let height: Height
    let id: Int
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String?
    let temperament: String?
    let origin: String?
    let referenceImageID: String?
    let image: DogImage?
     
    enum CodingKeys: String, CodingKey {
        case weight, height, id, name, origin, image
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case referenceImageID = "reference_image_id"
    }
}

struct Weight: Codable {
    let imperial: String?
    let metric: String?
}


struct Height: Codable {
    let imperial: String?
    let metric: String?
}

struct DogImage: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: String?
}
