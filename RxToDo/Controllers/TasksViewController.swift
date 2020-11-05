//
//  ViewController.swift
//  RxToDo
//
//  Created by admin on 21.10.2020.
//

import UIKit

class TasksViewController: UIViewController, BindableType {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var newTaskButton: UIBarButtonItem!
  
  var viewModel: TasksViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func bindViewModel() {
  }
  
}

