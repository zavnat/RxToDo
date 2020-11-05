//
//  SceneCoordinatorType.swift
//  RxToDo
//
//  Created by admin on 28.10.2020.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
  
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Completable
  
  @discardableResult
  func pop(animated: Bool) -> Completable
}

extension SceneCoordinatorType {
  @discardableResult
  func pop() -> Completable {
    return pop(animated: true)
  }
}
