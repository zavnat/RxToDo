//
//  ViewController.swift
//  RxToDo
//
//  Created by admin on 21.10.2020.
//

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx

class TasksViewController: UIViewController, BindableType {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var newTaskButton: UIBarButtonItem!
  
  var dataSource: RxTableViewSectionedAnimatedDataSource<TaskSection>!
  var viewModel: TasksViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    
    configureDataSource()
    setEditing(true, animated: false)
  }

  func bindViewModel() {
    viewModel.sectionedItems
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: self.rx.disposeBag)
    
    newTaskButton.rx.action = viewModel.onCreateTask()
    
    tableView.rx.itemSelected
      .do(onNext: { [unowned self] indexPath in
        self.tableView.deselectRow(at: indexPath, animated: false)
      })
      .map { [unowned self] indexPath in
        try! self.dataSource.model(at: indexPath) as! TaskItem
      }
      .bind(to: viewModel.editAction.inputs)
      .disposed(by: self.rx.disposeBag)
    
    tableView.rx.itemDeleted
      .map { [unowned self] indexPath in
        try! self.tableView.rx.model(at: indexPath)
      }
      .subscribe(viewModel.deleteAction.inputs)
      .disposed(by: self.rx.disposeBag)
  }
  
  private func configureDataSource() {
    dataSource = RxTableViewSectionedAnimatedDataSource(
      configureCell: {
        [weak self] dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskitemCell", for: indexPath) as! TaskItemTableViewCell
        if let self = self {
          cell.configure(with: item, action: self.viewModel.onToggle(task: item))
        }
        return cell
      }, titleForHeaderInSection: { dataSorce, index in
        self.dataSource.sectionModels[index].model
      },
      canEditRowAtIndexPath: { _, _ in true })
  }
  
}

