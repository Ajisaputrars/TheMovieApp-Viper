//
//  MainTabBarController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 01/02/21.
//

import UIKit
import Core
import Movie

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = #colorLiteral(red: 0, green: 0.5181589127, blue: 1, alpha: 1)
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    let moviePageController = MoviePageController(
      presenter: MoviePresenter(
        movieUseCase: Injection().provideMovieUseCase()
      )
    )
    let moviePageNavigationController = UINavigationController(rootViewController: moviePageController)
    moviePageNavigationController.tabBarItem = UITabBarItem(title: "Movies",
                                                            image: UIImage(systemName: "film"),
                                                            tag: 0)
    
    let searchPageController = SearchPageController(presenter: MoviePresenter(
      movieUseCase: Injection.init().provideMovieUseCase()
    ))
    let searchPageNavigationController = UINavigationController(rootViewController: searchPageController)
    searchPageNavigationController.tabBarItem = UITabBarItem(title: "Search",
                                                             image: UIImage(systemName: "magnifyingglass"),
                                                             tag: 1)

    let favoritePageController = FavoritePageController(
      presenter: FavoritePresenter(
        favoriteUseCase: Injection().provideGetAllFavoriteMovieUseCase()
      )
    )
    let favoritePageNavigationController = UINavigationController(rootViewController: favoritePageController)
    favoritePageNavigationController.tabBarItem = UITabBarItem(title: "Favorites",
                                                               image: UIImage(systemName: "star.fill"),
                                                               tag: 2)

    let profilePageController = ProfilePageController()
    let aboutPageNavigationController = UINavigationController(rootViewController: profilePageController)
    aboutPageNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                            image: UIImage(systemName: "person.fill"),
                                                            tag: 3)
    
    let tabBars = [moviePageController, searchPageController, favoritePageController, profilePageController]
    for tabBar in tabBars {
      tabBar.navigationController?.navigationBar.standardAppearance = appearance
      tabBar.navigationController?.navigationBar.tintColor = .white
      tabBar.navigationController?.navigationBar.prefersLargeTitles = false
      tabBar.navigationController?.navigationBar.isTranslucent = true
      tabBar.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    self.viewControllers = [moviePageNavigationController,
                            searchPageNavigationController,
                            favoritePageNavigationController,
                            aboutPageNavigationController]
  }
}
