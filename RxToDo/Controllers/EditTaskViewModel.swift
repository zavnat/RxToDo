//
//  EditTaskViewModel.swift
//  RxToDo
//
//  Created by admin on 28.10.2020.
//

import Foundation
import Action
import RxSwift

struct EditTaskViewModel {
  
  let itemTitle: String
  let onUpdate: Action<String,Void>
  let onCancel: CocoaAction
  let disposeBag = DisposeBag()
  
  init (task: TaskItem, coordinator: SceneCoordinatorType, updateAction: Action<String, Void>, cancelAction: CocoaAction? = nil) {
    itemTitle = task.title
    onUpdate = updateAction
    onCancel = CocoaAction {
      if let cancelAction = cancelAction {
        cancelAction.execute()
      }
      return coordinator.pop()
        .asObservable()
        .map{ _ in }
    }
    
    onUpdate.executionObservables
      .take(1)
      .subscribe (onNext: { _ in
        coordinator.pop()
      }).disposed(by: disposeBag)

  }
}
