//
//  MoviesListLocalManager.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 09/08/21.
//

import UIKit
import CoreData

class MoviesListLocalManager {

    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    static func clearMoviesList(entityName: String) {
        if let context = appDelegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(batchDeleteRequest)
                appDelegate?.saveContext()
            } catch {
                print("Could not delete \(error)")
            }
        }
    }
    
    static func saveCurrentMoviesList(_ movieInfoList: [MovieInfoModel], entityName: String) {
        if let context = appDelegate?.persistentContainer.viewContext {
            clearMoviesList(entityName: entityName)
            if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
                let nowPlayingMO = NSManagedObject(entity: entity, insertInto: context)
                let movieListData = try? JSONEncoder().encode(movieInfoList)
                nowPlayingMO.setValue(movieListData, forKeyPath: "movieListData")
                
                do {
                    try context.save()
                    appDelegate?.saveContext()
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    static func fetchMoviesList(entityName: String) -> [MovieInfoModel] {
        if let context = appDelegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            do {
                let moviesListLocal = try context.fetch(fetchRequest)
                if moviesListLocal.count > 0,
                   let loadedMovieListData = moviesListLocal[0].value(forKey: "movieListData") as? Data {
                    if let loadedMovieList = try? JSONDecoder().decode([MovieInfoModel].self, from: loadedMovieListData) {
                        return loadedMovieList
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return []
    }
}
