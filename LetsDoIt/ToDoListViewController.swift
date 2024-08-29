//
//  ViewController.swift
//  LetsDoIt
//
//  Created by Диас Сайынов on 29.08.2024.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    func showToDos(_ todos: [ToDo])
    func showError(_ errorMessage: String)
}

class ToDoListViewController: UIViewController, ToDoListViewProtocol {
    var presenter: ToDoListPresenterProtocol?
    var todos: [ToDo] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showToDos(_ todos: [ToDo]) {
        self.todos = todos
        tableView.reloadData()
    }
    
    func showError(_ errorMessage: String) {
        // Present error alert
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.todo
        cell.accessoryType = todo.completed ? .checkmark : .none
        return cell
    }
}
