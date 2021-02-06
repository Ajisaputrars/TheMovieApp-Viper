//
//  AboutPageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 01/02/21.
//

import UIKit

class ProfilePageController: UIViewController {
  private lazy var profilePageView = ProfilePageView(frame: self.view.frame)
//  var favoritePresenter: Favorite
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = self.profilePageView
    self.title = "Profile"
    
  }
  
}
