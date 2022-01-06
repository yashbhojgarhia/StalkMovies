//
//  SavedMoviesManager.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 09/08/21.
//

import UIKit
import CoreData

class SavedMoviesManager {
    
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    static func removeASavedMovie(_ movieInfo: MovieInfoModel) {
        if let context = appDelegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ConstantKeys.SAVED_MOVIES)
            fetchRequest.predicate = NSPredicate(format: "movieID == \(movieInfo.id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(batchDeleteRequest)
                NotificationCenter.default.post(name: Notification.Name(ConstantKeys.RELOAD_SAVED_CONTROLLER), object: nil)
                appDelegate?.saveContext()
            } catch {
                print("Remove Movie Error")
            }
        }
    }
    
    static func addAMovieToSavedMovies(_ movieInfo: MovieInfoModel) {
        if let context = appDelegate?.persistentContainer.viewContext {
            if checkMovieExistsInSavedMovies(movieInfo) { return }
            if let entity = NSEntityDescription.entity(forEntityName: ConstantKeys.SAVED_MOVIES, in: context) {
                let savedMovies = NSManagedObject(entity: entity, insertInto: context)
                let movieInfoData = try? JSONEncoder().encode(movieInfo)
                savedMovies.setValue(movieInfoData, forKeyPath: "movieInfoData")
                savedMovies.setValue(movieInfo.id, forKey: "movieID")
                do {
                    try context.save()
                    NotificationCenter.default.post(name: Notification.Name(ConstantKeys.RELOAD_SAVED_CONTROLLER), object: nil)
                    appDelegate?.saveContext()
                } catch let error as NSError {
                    print("Add error \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    static func checkMovieExistsInSavedMovies(_ movieInfo: MovieInfoModel) -> Bool {
        let savedItems = fetchSavedMoviesList()
        for item in savedItems {
            if item.id == movieInfo.id {
                return true
            }
        }
        return false
    }
    
    static func fetchSavedMoviesList() -> [MovieInfoModel] {
        var fetchedMovieInfoList: [MovieInfoModel] = []
        if let context = appDelegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: ConstantKeys.SAVED_MOVIES)
            do {
                let savedMovies = try context.fetch(fetchRequest)
                for loadedSavedMovieObject in savedMovies {
                    if let loadedMovieInfoData = loadedSavedMovieObject.value(forKey: "movieInfoData") as? Data,
                       let loadedMovieInfoModel = try? JSONDecoder().decode(MovieInfoModel.self, from: loadedMovieInfoData) {
                        fetchedMovieInfoList.append(loadedMovieInfoModel)
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return fetchedMovieInfoList
    }
}
