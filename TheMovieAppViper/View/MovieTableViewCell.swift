//
//  MovieTableViewCell.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 30/01/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .green
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let movieTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Grand Theft Auto V: The Revolutioner"
    label.numberOfLines = 2
    label.sizeToFit()
    label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let movieDateReleaseLabel: UILabel = {
    let label = UILabel()
    label.text = "20 Januari 2020"
    label.numberOfLines = 1
    label.font = UIFont.italicSystemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let movieOverviewLabel: UILabel = {
    let label = UILabel()
    label.text = "Sample overview dlfjdf djfdfdkf djkf dkfd fjdfkdjf djkfdskf dkfdk sjfkd jfkdj fkdjfkdj kfdjkfdkf dkfj dkfjd klfjkd fjkdfkd fkdfkdkf ldjklfdjklf dklfdjJjppgierg dfjdklf d"
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.9
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupView()
  }
  
  private func setupView() {
    self.backgroundColor = .white
    self.addSubview(self.movieImageView)
    self.movieImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
    self.movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
    self.movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    self.movieImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width / 3).isActive = true
    let constraint = self.movieImageView.heightAnchor.constraint(equalToConstant: (self.frame.size.width / 3) * 1.3)
    constraint.priority = UILayoutPriority(999)
    constraint.isActive = true
    
    self.addSubview(self.movieTitleLabel)
    self.movieTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
    self.movieTitleLabel.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor, constant: 8).isActive = true
    self.movieTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true

    self.addSubview(self.movieDateReleaseLabel)
    self.movieDateReleaseLabel.topAnchor.constraint(equalTo: self.movieTitleLabel.bottomAnchor, constant: 4).isActive = true
    self.movieDateReleaseLabel.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor, constant: 8).isActive = true
    self.movieDateReleaseLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    self.movieDateReleaseLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

    self.addSubview(self.movieOverviewLabel)
    self.movieOverviewLabel.topAnchor.constraint(equalTo: self.movieDateReleaseLabel.bottomAnchor, constant: 4).isActive = true
    self.movieOverviewLabel.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor, constant: 8).isActive = true
    self.movieOverviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16).isActive = true
    self.movieOverviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
