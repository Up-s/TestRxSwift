//
//  Step1ViewController.swift
//  TestRxSwift
//
//  Created by Lee on 2020/04/01.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import RxSwift

class Step1ViewController: UIViewController {
  
  override var description: String { "Step1ViewController" }
  
  private var disposeBag = DisposeBag()
  private let colors = [UIColor.systemRed, .systemBlue, .systemFill, .systemPink, .systemTeal]
  
  private let imageView = UIImageView()
  private let imageLoadButton = UIButton()
  private let colorChangeButton = UIButton()
  private let imageCancelButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    let guide = view.safeAreaLayoutGuide
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = .darkGray
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    
    
    imageLoadButton.setTitle(" 이미지 다운 ", for: .normal)
    imageLoadButton.backgroundColor = .darkGray
    imageLoadButton.addTarget(self, action: #selector(imageLoadButtonAction), for: .touchUpInside)
    view.addSubview(imageLoadButton)
    imageLoadButton.translatesAutoresizingMaskIntoConstraints = false
    imageLoadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
    imageLoadButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16).isActive = true
    
    
    colorChangeButton.setTitle(" 색 변경 ", for: .normal)
    colorChangeButton.backgroundColor = .darkGray
    colorChangeButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
    view.addSubview(colorChangeButton)
    colorChangeButton.translatesAutoresizingMaskIntoConstraints = false
    colorChangeButton.topAnchor.constraint(equalTo: imageLoadButton.bottomAnchor, constant: 16).isActive = true
    colorChangeButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16).isActive = true
    
    
    imageCancelButton.setTitle(" 취 소 ", for: .normal)
    imageCancelButton.backgroundColor = .darkGray
    imageCancelButton.addTarget(self, action: #selector(imageCancelButtonAction), for: .touchUpInside)
    view.addSubview(imageCancelButton)
    imageCancelButton.translatesAutoresizingMaskIntoConstraints = false
    imageCancelButton.topAnchor.constraint(equalTo: colorChangeButton.bottomAnchor, constant: 16).isActive = true
    imageCancelButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16).isActive = true
  }
    
  @objc private func imageLoadButtonAction(_ sender: UIButton) {
    imageView.image = nil
    
    rxswiftLoadImage(from: LARGE_IMAGE_URL)
      .observeOn(MainScheduler.instance)
      .subscribe { (result) in
        switch result {
        case let .next(image): // 완료했을때
          print("next")
          self.imageView.image = image
          
        case let .error(err):
          print(err.localizedDescription)
          
        case .completed: // 항상 호출
          print("completed")
        }
    }.disposed(by: disposeBag)
  }
  
  // 이미지 주소를 받아 Observable 을 반환
  func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
    return Observable.create { (seal) -> Disposable in
      asyncLoadImage(from: imageUrl) { (image) in
        seal.onNext(image)
        seal.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  @objc private func colorButtonAction() {
    view.backgroundColor = colors.randomElement()
  }
  
  @objc private func imageCancelButtonAction() {
    // DisposeBag 에 등록된 Observable 들을 취소
    disposeBag = DisposeBag()
  }
}
