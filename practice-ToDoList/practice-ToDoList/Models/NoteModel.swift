//
//  NoteModel.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import Foundation

struct NoteModel:Codable{
    let id: UUID
    var toDo: String
    var isDone: Bool
    let date: Date
    
    init(toDo:String) {
        self.id = UUID()
        self.toDo = toDo
        self.isDone = false
        self.date = Date()
    }
}
