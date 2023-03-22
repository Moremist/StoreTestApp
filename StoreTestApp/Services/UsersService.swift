//
//  UsersService.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 21.03.2023.
//

import Foundation
import CoreData
import UIKit

class UsersService: ObservableObject {
    static let shared = UsersService()
    
    @Published var currentUser: UserModel?
    
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "UsersDataModel")
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveData() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    func registerUser(name: String, email: String) throws {
        let user = UserModel(context: context)
        
        user.name = name
        user.email = email.lowercased()
        
        let id = UUID()
        user.id = id

        saveData()
        UserDefaults.standard.set(true, forKey: UserDefaults.Keys.loggedInKey)
        setCurrentUser(user: user)
    }
    
    private func setCurrentUser(user: UserModel) {
        currentUser = user
        UserDefaults.standard.set(user.email, forKey: UserDefaults.Keys.currentUserEmailKey)
    }
    
    func getUserByEmail(userEmail: String) -> UserModel? {
        let fetchRequest: NSFetchRequest<UserModel>
        fetchRequest = UserModel.fetchRequest()
        
        let idPredicate = NSPredicate(format: "email = %@", userEmail.lowercased())
        fetchRequest.predicate = idPredicate
        
        do {
            guard let user = try context.fetch(fetchRequest).first else { return nil }
            return user
        } catch {
            print("User with \(userEmail) didn't found")
            return nil
        }
    }
    
    func setUpCurrentUserIfNeeded() {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: UserDefaults.Keys.currentUserEmailKey) else { return }
        guard let user = getUserByEmail(userEmail: currentUserEmail) else { return }
        setCurrentUser(user: user)
    }
    
    func logOut() {
        UserDefaults.standard.set("", forKey: UserDefaults.Keys.currentUserEmailKey)
        UserDefaults.standard.set(false, forKey: UserDefaults.Keys.loggedInKey)
    }
    
    func clearUsers() {
        let fetchRequest: NSFetchRequest<UserModel>
        fetchRequest = UserModel.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                context.delete(result)
            }
            saveData()
        } catch let error {
            print("Delete all data in UserModel error :", error)
        }
    }
    
    func logInUser(user: UserModel) {
        self.currentUser = user
        UserDefaults.standard.set(user.email, forKey: UserDefaults.Keys.currentUserEmailKey)
        UserDefaults.standard.set(true, forKey: UserDefaults.Keys.loggedInKey)
    }
    
    func saveCurrentUserAvatar(image: UIImage) {
        let imageData = image.jpegData(compressionQuality: 1)
        guard let currentUserEmail = currentUser?.email else { return }
        if let user = getUserByEmail(userEmail: currentUserEmail) {
            user.avatar = imageData
        }
        saveData()
    }
    
    func getCurrentUserAvatar() -> UIImage? {
        if let imageData = currentUser?.avatar {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
}

