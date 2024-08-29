//
//  Task.swift
//  LetsDoIt
//
//  Created by Диас Сайынов on 29.08.2024.
//

import Foundation

struct ToDo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct ToDoResponse: Codable {
    let todos: [ToDo]
    let total: Int
    let skip: Int
    let limit: Int
}


