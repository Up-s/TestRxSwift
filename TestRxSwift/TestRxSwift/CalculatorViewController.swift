//
//  CalculatorViewController.swift
//  TestRxSwift
//
//  Created by Lee on 2020/04/03.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import RxSwift

class CalculatorViewController: UIViewController {
  
  private let firstTextField = UITextField()
  private let secondTextField = UITextField()
  private let sumLabel = UILabel()
  
  private var disposeBag = DisposeBag()
  private var first: Int?
  private var second: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    
    [firstTextField, secondTextField].forEach {
      $0.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
    }
  }
  
  @objc private func textFieldAction(_ sender: UITextField) {
    guard let text = sender.text else { return }
    sender == firstTextField ?
      (first = Int(text)) :
      (second = Int(text))
    
    updateNumber()
  }
  
  private func updateNumber() {
    let firstOb = Observable.just(first)
    let secondOb = Observable.just(second)
    
    let combine = Observable.combineLatest([firstOb, secondOb])
    combine.subscribe(onNext: { [weak self] in
      let sum = $0
        .compactMap { $0 }
        .reduce(0) { $0 + $1 }
        
      self?.sumLabel.text = String(sum)
    })
    .disposed(by: disposeBag)
  }
  
  private func setUI() {
    view.backgroundColor = .white
    let guide = view.safeAreaLayoutGuide
    
    [firstTextField, secondTextField, sumLabel].forEach {
      $0.backgroundColor = .gray
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
      $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
      $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    firstTextField.trailingAnchor.constraint(equalTo: secondTextField.leadingAnchor, constant: -24).isActive = true
    
    secondTextField.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
    sumLabel.leadingAnchor.constraint(equalTo: secondTextField.trailingAnchor, constant: 24).isActive = true
  }
}
