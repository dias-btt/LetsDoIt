//
//  ToDoListRouter.swift
//  LetsDoIt
//
//  Created by Диас Сайынов on 29.08.2024.
//

import Foundation
import UIKit

protocol ToDoListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class ToDoListRouter: ToDoListRouterProtocol {
    static func createModule() -> UIViewController {
        let viewController = ToDoListViewController()
        let presenter: ToDoListPresenterProtocol & ToDoListInteractorOutputProtocol = ToDoListPresenter()
        let interactor: ToDoListInteractorInputProtocol = ToDoListInteractor()
        let router: ToDoListRouterProtocol = ToDoListRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
}
