//
//  EditNoteViewModel.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 20.08.2023.
//

import Foundation

final class EditNoteViewModel{
    
    let viewController: EditNoteViewController
    let dbManager: DbManager = DbManager()
    
    init(viewController: EditNoteViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad(){
        
    }
    
    func editNote(indexPath: IndexPath, note: String){
        let i = viewController.navigationController?.viewControllers.firstIndex(of: viewController)
        let previousViewController: MainViewController = viewController.navigationController?.viewControllers[i!-1] as! MainViewController
        
        previousViewController.list[indexPath.row].toDo = note

        dbManager.userDefaultsService.saveList(list: previousViewController.list)
        previousViewController.tableView.reloadData()
        //optimizasyon yapılabilir
        viewController.navigationController?.popViewController(animated: true)
    }
}
