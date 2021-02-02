//
//  DetailPageView.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import UIKit

class DetailPageView: UIView {
  
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .green
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let movieNameLabel: UILabel = {
    let label = UILabel()
    label.text = "GTA V: The Last Airbender"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let movieReleaseDateLabel: UILabel = {
    let label = UILabel()
    label.text = "20 Juni 2020"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let movieOverviewLabel: UILabel = {
    let label = UILabel()
    label.text = "dfkdjfkd fkdjfkdjfkd kfdjkfj dkfjdkfjdk fjkd jfkdj fkd jfkd kfdj kfdj kfdjk fjdk fjd fjd fjkdj fkdj fkdj kfdj kfj dkfj dklfjkdljfkdjf kdjf kdj fkdj fkdj kfd jkfdj kfjdklfjdklfj dkfjkldfjkdlf kld fkld fkld fkd klfdklf dklf kldf kld fkld fkldfkld fkld fkldjk fld kfd klfjdkl f kldf kldf kldf kldf kld flkd fkld kfld kfdk fdk fkdf kd fkd fkdj fkdf dk fkdlf kdj fkdjf kdjkf djk fdkfkd fkd fkd fkdfdk fjkdfjkdjf"
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }
  
  private func setupView() {
    self.backgroundColor = .white
    
    self.addSubview(self.scrollView)
    self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
    self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
    
    self.scrollView.addSubview(self.movieImageView)
    self.movieImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 16).isActive = true
    self.movieImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
    self.movieImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    self.movieImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    
    self.scrollView.addSubview(self.movieNameLabel)
    self.movieNameLabel.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 16).isActive = true
    self.movieNameLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 16).isActive = true
//    self.movieNameLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -16).isActive = true
    self.movieNameLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -16).isActive = true
    self.movieNameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
    
    self.scrollView.addSubview(self.movieReleaseDateLabel)
    self.movieReleaseDateLabel.topAnchor.constraint(equalTo: self.movieNameLabel.bottomAnchor, constant: 16).isActive = true
    self.movieReleaseDateLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 16).isActive = true
    self.movieReleaseDateLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -16).isActive = true
    
    self.scrollView.addSubview(self.movieOverviewLabel)
    self.movieOverviewLabel.topAnchor.constraint(equalTo: self.movieReleaseDateLabel.bottomAnchor, constant: 16).isActive = true
    self.movieOverviewLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 16).isActive = true
    self.movieOverviewLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -16).isActive = true
    self.movieOverviewLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -16).isActive = true
    
    movieNameLabel.backgroundColor = .green
    movieReleaseDateLabel.backgroundColor = .yellow
    movieOverviewLabel.backgroundColor = .magenta
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}



