//
//  TaskServiceType.swift
//  RxToDo
//
//  Created by admin on 03.11.2020.
//

import Foundation
import RxSwift
import RealmSwift

enum TaskServiceError: Error {
  case creationFailed
  case updateFailed
  case deletionFailed
  case toggleFailed
}

protocol TaskServiceType {
  @discardableResult
  func createTask(title: String) -> Observable<TaskItem>
  
  @discardableResult
  func delete(task: TaskItem) -> Observable<Void>
  
  @discardableResult
  func update(task: TaskItem, title: String) -> Observable<TaskItem>
  
  @discardableResult
  func toggle(task: TaskItem) -> Observable<TaskItem>
  
  func tasks() -> Observable<Results<TaskItem>>
  
}
