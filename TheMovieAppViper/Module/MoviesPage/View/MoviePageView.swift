//
//  MainPageView.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 30/01/21.
//

import UIKit

class MoviePageView: UIView {
  
  let loadingIndicatorView: UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView(style: .large)
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    return loadingView
  }()
  
  let loadingLabel: UILabel = {
    let label = UILabel()
    label.text = "Loading"
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let movieTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  func setupLoadingView(isLoading: Bool) {
    self.movieTableView.isHidden = isLoading
    self.loadingLabel.isHidden = !isLoading
    self.loadingIndicatorView.isHidden = !isLoading
    if isLoading {
      self.loadingIndicatorView.startAnimating()
    } else {
      self.loadingIndicatorView.stopAnimating()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }
  
  private func setupView() {
    self.backgroundColor = .white
    
    self.addSubview(self.movieTableView)
    self.movieTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.movieTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.movieTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    self.movieTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
    
    self.addSubview(self.loadingIndicatorView)
    self.loadingIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    self.addSubview(self.loadingLabel)
    self.loadingLabel.topAnchor.constraint(equalTo: self.loadingIndicatorView.bottomAnchor, constant: 8).isActive = true
    self.loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
