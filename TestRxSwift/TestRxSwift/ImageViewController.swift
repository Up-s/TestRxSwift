//
//  ImageViewController.swift
//  TestRxSwift
//
//  Created by Lee on 2020/04/06.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  
  let imageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  private func setUI() {
    let guide = view.safeAreaLayoutGuide
    
    view.backgroundColor = .white
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    view.addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
  }
}
