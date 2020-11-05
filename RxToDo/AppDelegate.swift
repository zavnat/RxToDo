//
//  AppDelegate.swift
//  RxToDo
//
//  Created by admin on 21.10.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    let service = TaskService()
    let sceneCoordinator = SceneCoordinator(window: window!)

    let tasksViewModel = TasksViewModel()
    let firstScene = Scene.tasks(tasksViewModel)
    sceneCoordinator.transition(to: firstScene, type: .root)
    return true
  }

}

