//
//  Step2ViewController.swift
//  TestRxSwift
//
//  Created by Lee on 2020/04/01.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import RxSwift

class Step2ViewController: UITableViewController {
  
  override var description: String { "Step2ViewController" }
  
  private var disposeBag = DisposeBag()
  
  private let cellList = ["exJust1", "exJust2", "exFrom1", "exMap1", "exMap2", "exFilter", "exMap3"]
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cellList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    cell.textLabel?.text = cellList[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      Observable
        .just("Hello world")
        .subscribe { (str) in
          print(str)
      }
      .disposed(by: disposeBag)
      
    default:
      break
    }
  }
}
