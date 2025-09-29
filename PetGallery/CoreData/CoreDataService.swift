//
//  CoreDataService.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 29.09.25.
//

import Foundation
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    
    let container: NSPersistentContainer
    
    private init () {
        container = NSPersistentContainer(name: "PetModel")
        container.loadPersistentStores { _,error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveFavorite(id: String) {
        let favorite = PetEntity(context: context)
        favorite.id = id
        
        do{
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavoriteIds() -> [String] {
        let fetchRequest: NSFetchRequest<PetEntity> = PetEntity.fetchRequest()
        do {
            let entities = try context.fetch(fetchRequest)
            return entities.compactMap { $0.id }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteItemById(id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PetEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
            for object in objects ?? [] {
                context.delete(object)
            }
            try context.save()
        } catch let error as NSError {
            print("Could not fetch or delete. \(error)")
        }
    }
    
    
    
    
}
