//
//  Scene+ViewController.swift
//  RxToDo
//
//  Created by admin on 28.10.2020.
//

import UIKit


extension Scene {
  func viewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    switch self {
    case .tasks(let viewModel):
      let nc = storyboard.instantiateViewController(identifier: "Tasks") as! UINavigationController
      let vc = nc.viewControllers.first as! TasksViewController
      vc.bindViewModel(to: viewModel)
      return nc
    case .editTask(let viewModel):
      let nc = storyboard.instantiateViewController(identifier: "EditTasks") as! UINavigationController
      let vc = nc.viewControllers.first as! EditViewController
      vc.bindViewModel(to: viewModel)
      return nc
    }
  }
}
