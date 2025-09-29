//
//  FileManager.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 26.09.25.
//

import Foundation

class JsonFileManager {
    
    static let shared = JsonFileManager()  
    
    private init() {} 
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(files)
        
        let file = files[0].appendingPathComponent("User.json")
        return file
    }
    
    func readUserDataFromFile(completion: (([User]) -> Void)) {
        let path = getFilePath()
        print(path)
        
        guard FileManager.default.fileExists(atPath: path.path) else {
            completion([])
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let model = try JSONDecoder().decode([User].self, from: data)
            completion(model)
        } catch {
            print(error.localizedDescription)
            completion([])
        }
    }
    
    func saveDataToFile(users: [User]) {
        do {
            let model = try JSONEncoder().encode(users)
            let path = getFilePath()
            try model.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
