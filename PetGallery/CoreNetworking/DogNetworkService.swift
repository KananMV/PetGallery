//
//  DogNetworkService.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 27.09.25.
//

import Foundation
import Alamofire

class DogNetworkService {
    static let shared = DogNetworkService()
    
    private init() {}
    
    func getDogs(completion: @escaping (Result<[Dog], Error>) -> Void) {
        let url = "\(Constants.dogBaseURL.rawValue)/breeds"
        
        let headers: HTTPHeaders = [
            "x-api-key": Constants.dogApiKey
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: [Dog].self) { response in
            switch response.result {
            case .success(let breeds):
                completion(.success(breeds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDogById(id: String, completion: @escaping (Result<Dog, Error>) -> Void) {
        let url = "\(AppURL.dogBase.rawValue)/breeds/\(id)"
        
        let headers: HTTPHeaders = [
            "x-api-key": Constants.dogApiKey
        ]
        
        AF.request(url, headers: headers)
            .responseDecodable(of: Dog.self) { response in
                switch response.result {
                case .success(let dog):
                    completion(.success(dog))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
