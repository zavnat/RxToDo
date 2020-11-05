//
//  BindableType.swift
//  RxToDo
//
//  Created by admin on 29.10.2020.
//

import UIKit

protocol BindableType: AnyObject {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindViewModel()
}

extension BindableType where Self: UIViewController {
  func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
}
