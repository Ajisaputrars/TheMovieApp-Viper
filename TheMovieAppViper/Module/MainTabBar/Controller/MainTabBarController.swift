//
//  MainTabBarController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 01/02/21.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .red
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    let moviePageController = MoviePageController()
    moviePageController.moviePresenter = MoviePresenter(movieUseCase: Injection.init().provideMovieUseCase())
    let moviePageNavigationController = UINavigationController(rootViewController: moviePageController)
    moviePageNavigationController.tabBarItem = UITabBarItem(title: "Movies",
                                                            image: UIImage(systemName: "film"),
                                                            tag: 0)

    let favoritePageController = FavoritePageController()
    let favoritePageNavigationController = UINavigationController(rootViewController: favoritePageController)
    favoritePageNavigationController.tabBarItem = UITabBarItem(title: "Favorite",
                                                               image: UIImage(systemName: "star.fill"),
                                                               tag: 1)

    let profilePageController = ProfilePageController()
    let aboutPageNavigationController = UINavigationController(rootViewController: profilePageController)
    aboutPageNavigationController.tabBarItem = UITabBarItem(title: "About",
                                                            image: UIImage(systemName: "person.fill"),
                                                            tag: 2)
    
    let tabBars = [moviePageController, favoritePageController, profilePageController]
    for tabBar in tabBars {
      tabBar.navigationController?.navigationBar.standardAppearance = appearance
      tabBar.navigationController?.navigationBar.tintColor = .white
      tabBar.navigationController?.navigationBar.prefersLargeTitles = false
      tabBar.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    self.viewControllers = [moviePageNavigationController,
                            favoritePageNavigationController,
                            aboutPageNavigationController]
  }
}
