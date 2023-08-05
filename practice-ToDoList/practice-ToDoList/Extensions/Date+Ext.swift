//
//  Date+Ext.swift
//  practice-ToDoList
//
//  Created by Burhan AFŞAR on 5.08.2023.
//

import Foundation

extension Date
{
    //dd-MM
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
