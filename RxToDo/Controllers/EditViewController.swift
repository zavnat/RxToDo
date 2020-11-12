//
//  EditViewController.swift
//  RxToDo
//
//  Created by admin on 28.10.2020.
//

import UIKit

class EditViewController: UIViewController, BindableType {
  
  @IBOutlet weak var okButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var titleView: UITextView!
  
  var viewModel: EditTaskViewModel!
  
  func bindViewModel() {
    titleView.text = viewModel.itemTitle
    
    cancelButton.rx.action = viewModel.onCancel
    
    okButton.rx.tap
      .withLatestFrom(titleView.rx.text.orEmpty)
      .bind(to: viewModel.onUpdate.inputs)
      .disposed(by: self.rx.disposeBag)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    titleView.becomeFirstResponder()
  }
  
}
