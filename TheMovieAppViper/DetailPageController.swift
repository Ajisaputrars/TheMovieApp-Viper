//
//  DetailPageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 30/01/21.
//

import UIKit

class DetailPageController: UIViewController {
  
  private lazy var detailPageView = DetailPageView(frame: self.view.frame)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Detail Movie"
    self.view = self.detailPageView
  }
  
}
