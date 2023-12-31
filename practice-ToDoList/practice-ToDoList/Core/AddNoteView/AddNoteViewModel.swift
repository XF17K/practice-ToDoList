//
//  AddNoteViewModel.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import Foundation

final class AddNoteViewModel{
    let viewController: AddNoteViewController
    let dbManager: DbManager = DbManager()
    
    init(viewController: AddNoteViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad(){
        
    }
    
    func addNote(note: String){
        let i = viewController.navigationController?.viewControllers.firstIndex(of: viewController)
        let previousViewController: MainViewController = viewController.navigationController?.viewControllers[i!-1] as! MainViewController
        
        let newNote: NoteModel = NoteModel(toDo: note)
        previousViewController.list.append(newNote)
        dbManager.userDefaultsService.saveList(list: previousViewController.list)
        previousViewController.tableView.reloadData()
        //optimizasyon yapılabilir
        viewController.navigationController?.popViewController(animated: true)
    }
}
