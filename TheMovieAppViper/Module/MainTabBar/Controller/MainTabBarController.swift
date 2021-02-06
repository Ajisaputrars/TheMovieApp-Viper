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
    appearance.backgroundColor = #colorLiteral(red: 0, green: 0.5181589127, blue: 1, alpha: 1)
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    let moviePageController = MoviePageController(
      presenter: MoviePresenter(
        movieUseCase: Injection.init()
          .provideMovieUseCase()
      )
    )
    let moviePageNavigationController = UINavigationController(rootViewController: moviePageController)
    moviePageNavigationController.tabBarItem = UITabBarItem(title: "Movies",
                                                            image: UIImage(systemName: "film"),
                                                            tag: 0)

    let favoritePageController = FavoritePageController(
      presenter: FavoritePresenter(
        favoriteUseCase: Injection.init().provideFavoriteMovieUseCase()
      )
    )
    let favoritePageNavigationController = UINavigationController(rootViewController: favoritePageController)
    favoritePageNavigationController.tabBarItem = UITabBarItem(title: "Favorites",
                                                               image: UIImage(systemName: "star.fill"),
                                                               tag: 1)

    let profilePageController = ProfilePageController()
    let aboutPageNavigationController = UINavigationController(rootViewController: profilePageController)
    aboutPageNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                            image: UIImage(systemName: "person.fill"),
                                                            tag: 2)
    
    let tabBars = [moviePageController, favoritePageController, profilePageController]
    for tabBar in tabBars {
      tabBar.navigationController?.navigationBar.standardAppearance = appearance
      tabBar.navigationController?.navigationBar.tintColor = .white
      tabBar.navigationController?.navigationBar.prefersLargeTitles = false
      tabBar.navigationController?.navigationBar.isTranslucent = true
      tabBar.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    self.viewControllers = [moviePageNavigationController,
                            favoritePageNavigationController,
                            aboutPageNavigationController]
  }
}
