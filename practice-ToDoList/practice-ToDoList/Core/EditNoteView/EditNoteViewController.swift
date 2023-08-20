//
//  EditNoteViewController.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 20.08.2023.
//

import UIKit
import SnapKit

final class EditNoteViewController: UIViewController{
    
    //MARK: -VARIABLES
    private lazy var viewModel = EditNoteViewModel(viewController: self)
    
    let indexPath: IndexPath
    let toDo: String
    
    init(indexPath: IndexPath, toDo: String) {
        self.indexPath = indexPath
        self.toDo = toDo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    private let noteTextField: UITextField = {
        let noteTextField = UITextField()
        noteTextField.borderStyle = UITextField.BorderStyle.roundedRect
        noteTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return noteTextField
    }()
    
    private let noteLabel: UILabel = {
       let noteLabel = UILabel()
        noteLabel.text = "To-Do:"
        noteLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return noteLabel
    }()
    
    private let confirmButton: UIButton = {
        let confirmButton = UIButton()
        confirmButton.setTitle("Save", for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.layer.cornerRadius = 8
        confirmButton.addTarget(self, action: #selector(tappedConfirm), for: .touchUpInside)
        return confirmButton
    }()
    
    //MARK: -LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Edit To-Do"
        noteTextField.text = toDo
        viewModel.viewDidLoad()
        style()
        layout()
        
    }
    
    private func style(){
        view.addSubview(vStackView)
        view.addSubview(confirmButton)
        vStackView.addArrangedSubview(noteLabel)
        vStackView.addArrangedSubview(noteTextField)
        noteTextField.backgroundColor = .secondarySystemBackground
    }
    
    private func layout(){
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        noteTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(vStackView.snp.bottom).offset(16)
            make.centerX.equalTo(view.center.x)
            make.width.greaterThanOrEqualTo(100)
        }
    }
    
    @objc
    private func tappedConfirm(){
        print("tapped confirm")
        if(noteTextField.text?.isEmpty == false){
            viewModel.editNote(indexPath: indexPath, note: noteTextField.text!)
        }
        else{
            return
            //error message
        }
        
        //navigationController?.popViewController(animated: true)
    }
    
}
