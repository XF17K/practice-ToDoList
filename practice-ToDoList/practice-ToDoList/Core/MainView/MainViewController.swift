//
//  MainViewController.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    //MARK: -VARIABLES
    
    var list:[NoteModel] = TestData.list
    private lazy var viewModel = MainViewModel(viewController: self)
    
    
    //MARK: -UI COMPONENTS
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    //MARK: -LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        
        style()
        layout()
        
    }
    
    private func style(){
        //Navigation Controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "To-Do List"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.isEditing = false
        //TableView
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.backgroundColor = .red
        //tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    @objc
    private func addTapped(){
        let viewController = AddNoteViewController()
        super.isEditing = false
        self.navigationController?.pushViewController(viewController, animated: true)
        print("tapped to +")
    }
    
    override func setEditing (_ editing:Bool, animated:Bool)
{
    super.setEditing(editing, animated: animated)
    //tableView.isEditing.toggle()
    if(self.isEditing)
    {
        self.editButtonItem.title = "Done"
        tableView.setEditing(true, animated: true)
    }else
    {
        self.editButtonItem.title = "Edit"
        tableView.setEditing(false, animated: true)
        viewModel.saveData()
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: -EXTENSION
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = list[indexPath.row].toDo
        content.secondaryText = list[indexPath.row].date.toString(dateFormat: "dd-MM")
        content.image = list[indexPath.row].isDone ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.ToggleNote(indexPath: indexPath)
        //print(list[indexPath.row].toDo)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cancelAction = UIContextualAction(style: .normal, title: "Cancel") { (_, _, completionHandler) in
            print("Cancel")
            completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            
            super.isEditing = false
            let editNoteViewController = EditNoteViewController(indexPath: indexPath, toDo: self.list[indexPath.row].toDo)
            self.navigationController?.pushViewController(editNoteViewController, animated: true)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemGreen
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            self.viewModel.removeNote(indexPath: indexPath)
            //print("test")
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction, cancelAction])
    }
    //MOVE
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(cell, at: destinationIndexPath.row)
    }
}
