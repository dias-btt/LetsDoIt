//
//  ToDoListPresenter.swift
//  LetsDoIt
//
//  Created by Диас Сайынов on 29.08.2024.
//

import Foundation

protocol ToDoListPresenterProtocol: AnyObject {
    var view: ToDoListViewProtocol? { get set }
    var interactor: ToDoListInteractorInputProtocol? { get set }
    var router: ToDoListRouterProtocol? { get set }
    
    func viewDidLoad()
}

class ToDoListPresenter: ToDoListPresenterProtocol {
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorInputProtocol?
    var router: ToDoListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchToDos{ success in
            switch success{
            case .success(let task):
                print(task)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ToDoListPresenter: ToDoListInteractorOutputProtocol {
    func didFetchToDos(_ todos: [ToDo]) {
        view?.showToDos(todos)
    }
    
    func didFailToFetchToDos(with error: Error) {
        view?.showError(error.localizedDescription)
    }
}


