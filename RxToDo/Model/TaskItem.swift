//
//  TaskItem.swift
//  RxToDo
//
//  Created by admin on 03.11.2020.
//

import Foundation
import RealmSwift
import RxDataSources


class TaskItem: Object {
  @objc dynamic var uid = 0
  @objc dynamic var title = ""
  
  @objc dynamic var added = Date()
  @objc dynamic var checked: Date? = nil
  
  override class func primaryKey() -> String? {
    return "uid"
  }
}

extension TaskItem: IdentifiableType {
  var identity: Int {
    return self.isInvalidated ? 0 : uid
  }
}
