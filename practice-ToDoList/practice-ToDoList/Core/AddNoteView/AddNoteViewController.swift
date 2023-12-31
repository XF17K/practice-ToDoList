//
//  AddNoteViewController.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import UIKit
import SnapKit

class AddNoteViewController: UIViewController {

    //MARK: -VARIABLES
    private lazy var viewModel = AddNoteViewModel(viewController: self)
    
    
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
        confirmButton.setTitle("OK", for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.layer.cornerRadius = 8
        confirmButton.addTarget(self, action: #selector(tappedConfirm), for: .touchUpInside)
        return confirmButton
    }()
    //MARK: -LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Add To-Do"
        style()
        layout()
        // Do any additional setup after loading the view.
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
            viewModel.addNote(note: noteTextField.text!)
        }
        else{
            return
            //error message
        }
        
        //navigationController?.popViewController(animated: true)
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
