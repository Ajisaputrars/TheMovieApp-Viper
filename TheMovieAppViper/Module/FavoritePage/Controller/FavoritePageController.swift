//
//  FavoritePageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 01/02/21.
//

import UIKit

class FavoritePageController: UIViewController {
  private lazy var moviePageView = MoviePageView(frame: self.view.frame)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = self.moviePageView
    self.title = "Favorite"
    
    self.moviePageView.movieTableView.delegate = self
    self.moviePageView.movieTableView.dataSource = self
    
    self.moviePageView.setupLoadingView(isLoading: true)
    DispatchQueue.global().async {
      Thread.sleep(forTimeInterval: 2)
      
      DispatchQueue.main.async {
        self.moviePageView.setupLoadingView(isLoading: false)
      }
    }
  }
  
}

extension FavoritePageController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell {
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let controller = DetailPageController()
    controller.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
}
