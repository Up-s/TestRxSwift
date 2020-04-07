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
      
    case 1:
      Observable
        .just(["Hello", "world"])
        .subscribe { (arr) in
          print(arr)
      }.disposed(by: disposeBag)
      
    case 2:
      Observable
        .from([1, 2, 3])
        .subscribe { num in
          print(num)
      }
      .disposed(by: disposeBag)
      
    case 3:
      Observable
        .just("Hello")
        .map { str in "\(str) RxSwift" }
        .subscribe { (str) in
          print(str)
      }
      .disposed(by: disposeBag)
      
    case 4:
      Observable
        .from(["dldbdjq", "이유업"])
        .map { $0.count }
        .subscribe { (str) in
          print(str)
      }
      .disposed(by: disposeBag)
      
    case 5:
      Observable
        .from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        .filter { $0 % 2 == 0 }
        .subscribe { (n) in
          print(n)
      }
      .disposed(by: disposeBag)
      
    case 6:
      Observable
        .just("800x600")
        .map { $0.replacingOccurrences(of: "x", with: "/") }
        .map { "https://picsum.photos/\($0)/?random" }
        .map { URL(string: $0) }
        .filter { $0 != nil }
        .map { $0! }
        .map { try Data(contentsOf: $0) }
        .map { UIImage(data: $0) }
        .subscribe(onNext: { [weak self] (image) in
          guard let self = self else { return }
          
          let vcImage = ImageViewController()
          vcImage.imageView.image = image
          
          self.present(vcImage, animated: true)
        })
        .disposed(by: disposeBag)
      
    default:
      break
    }
  }
}
