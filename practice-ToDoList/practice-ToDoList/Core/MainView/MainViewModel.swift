//
//  MainViewModel.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import Foundation

final class MainViewModel{
    let viewController: MainViewController
    let dbManager: DbManager = DbManager()
    
    init(viewController: MainViewController){
        self.viewController = viewController
    }
    func viewDidLoad(){
        fetchData()
    }
    
    func fetchData(){
        if let savedList = dbManager.userDefaultsService.fetchList(){
            viewController.list = savedList
        }
    }
    
    func saveData(){
        dbManager.userDefaultsService.saveList(list: viewController.list)
    }
    
    func ToggleNote(indexPath: IndexPath){
        viewController.list[indexPath.row].isDone.toggle()
        viewController.tableView.reloadRows(at: [indexPath], with: .automatic)
        saveData()
    }
    
    func removeNote(indexPath: IndexPath){
        viewController.list.remove(at: indexPath.row)
        viewController.tableView.reloadData()
        dbManager.userDefaultsService.saveList(list: viewController.list)
    }
    
    func updateList(list: [NoteModel]){
        viewController.list = list
    }
}
