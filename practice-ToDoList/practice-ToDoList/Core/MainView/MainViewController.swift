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
    
    private let viewModel = MainViewModel()
    private let list:[NoteModel] = TestData.list
    
    //MARK: -UI COMPONENTS
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    //MARK: -LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        self.isEditing = true
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
        print("tapped to +")
    }
    
    override func setEditing (_ editing:Bool, animated:Bool)
{
    super.setEditing(editing,animated:animated)
    if(self.isEditing)
    {
        self.editButtonItem.title = "Edit"
    }else
    {
        self.editButtonItem.title = "Done"
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
        print(list[indexPath.row].toDo)
    }
}
