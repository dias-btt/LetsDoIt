//
//  ToDoListInteractor.swift
//  LetsDoIt
//
//  Created by Диас Сайынов on 29.08.2024.
//

import Foundation
import Alamofire

protocol ToDoListInteractorInputProtocol: AnyObject {
    func fetchToDos(completion: @escaping (Result<[ToDo], Error>) -> Void)
    var presenter: ToDoListPresenterProtocol? {get set}
}

protocol ToDoListInteractorOutputProtocol: AnyObject {
    func didFetchToDos(_ todos: [ToDo])
    func didFailToFetchToDos(with error: Error)
}

class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var presenter: ToDoListPresenterProtocol?
    
    func fetchToDos(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        let url = "https://dummyjson.com/todos"
        
        AF.request(url).responseDecodable(of: ToDoResponse.self) { response in
            switch response.result {
            case .success(let taskResponse):
                completion(.success(taskResponse.todos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

