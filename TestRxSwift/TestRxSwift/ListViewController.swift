//
//  ListViewController.swift
//  TestRxSwift
//
//  Created by Lee on 2020/04/01.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
  
  private let viewControllers = [CalculatorViewController(), Step1ViewController(), Step2ViewController()]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "List"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    cell.textLabel?.text = viewControllers[indexPath.row].description
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = viewControllers[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
    
}
