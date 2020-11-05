//
//  TaskService.swift
//  RxToDo
//
//  Created by admin on 03.11.2020.
//

import Foundation
import RealmSwift
import RxSwift

struct TaskService: TaskServiceType {
  
  init() {
    do {
      let realm = try Realm()
      if realm.objects(TaskItem.self).count == 0 {
        ["Сварить кофе",
         "Погулять в парке",
         "Позвонить в банк",
         "Выучить 10 английских слов",
         "Сгонять за покупками"
        ].forEach {
          self.createTask(title: $0)
        }
      }
    } catch _{
    }
  }
  
  private func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
    do {
      let realm = try Realm()
      return try action(realm)
    } catch let err {
      print("Failed \(operation) realm with error: \(err)")
      return nil
    }
  }
  
  @discardableResult
  func createTask(title: String) -> Observable<TaskItem> {
    let result = withRealm("creating") { realm -> Observable<TaskItem> in
      let task = TaskItem()
      task.title = title
      try realm.write {
        task.uid = (realm.objects(TaskItem.self).max(ofProperty: "uid") ?? 0) + 1
        realm.add(task)
      }
      return .just(task)
    }
    return result ?? .error(TaskServiceError.creationFailed)
  }
  
  @discardableResult
  func delete(task: TaskItem) -> Observable<Void> {
    let result = withRealm("deleting") { realm -> Observable<Void> in
      try realm.write {
        realm.delete(task)
      }
      return .empty()
    }
    return result ?? .error(TaskServiceError.deletionFailed)
  }
  
  func update(task: TaskItem, title: String) -> Observable<TaskItem> {
    
  }
  
  func toggle(task: TaskItem) -> Observable<TaskItem> {
    <#code#>
  }
  
  func tasks() -> Observable<Results<TaskItem>> {
    <#code#>
  }
  
  
}
