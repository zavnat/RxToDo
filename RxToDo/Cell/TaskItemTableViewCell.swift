//
//  TaskItemTableViewCell.swift
//  RxToDo
//
//  Created by admin on 28.10.2020.
//

import UIKit
import Action
import RxSwift

class TaskItemTableViewCell: UITableViewCell {

  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var button: UIButton!
  private var disposeBag = DisposeBag()
  
  func configure(with item: TaskItem, action: CocoaAction) {
    button.rx.action = action
    
    item.rx.observe(String.self, "title")
      .subscribe { [weak self] title in
        self?.title.text = title
      }.disposed(by: disposeBag)
    
    item.rx.observe(Date.self, "checked")
      .subscribe(onNext: { [weak self] date in
        let image = UIImage(named: date == nil ? "ItemNotChecked" : "ItemChecked")
        self?.button.setImage(image, for: .normal)
      }).disposed(by: disposeBag)

  }
  
  override func prepareForReuse() {
    button.rx.action = nil
    disposeBag = DisposeBag()
    super.prepareForReuse()
  }
}
