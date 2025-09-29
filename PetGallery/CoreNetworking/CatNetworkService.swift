//
//  CatNetworkService.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 28.09.25.
//

import Foundation
import Alamofire

class CatNetworkService {
    static let shared = CatNetworkService()
    
    private init() {}
    
    func getCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        let url = "\(AppURL.catBase.rawValue)/breeds"
        
        let headers: HTTPHeaders  = [
            "x-api-key": Constants.catApiKey
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: [Cat].self) { response in
            switch response.result {
            case .success(let cats):
                completion(.success(cats))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
}
