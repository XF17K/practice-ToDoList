//
//  UserDefaultsService.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 10.08.2023.
//

import Foundation

final class UserDefaultsService{
    
    func fetchList()->[NoteModel]?{
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: "list") as? Data{
            do{
                let savedList = try JSONDecoder().decode([NoteModel].self, from: savedData)
                return savedList
            }
            catch{
                print("Error: Reading Data")
                return nil
            }
        }
        return nil
    }
    
    func saveList(list: [NoteModel]){
        do{
            let encodedData = try JSONEncoder().encode(list)
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: "list")
        }
        catch{
            print("Error: Saving Data")
        }
    }
}
