//
//  NoteModel.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import Foundation

struct NoteModel{
    let id: UUID
    let toDo: String
    let isDone: Bool
    let date: Date
    
    init(toDo:String) {
        self.id = UUID()
        self.toDo = toDo
        self.isDone = false
        self.date = Date()
    }
}
