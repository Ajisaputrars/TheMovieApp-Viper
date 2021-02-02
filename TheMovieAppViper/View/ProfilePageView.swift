//
//  AboutPageView.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 01/02/21.
//

import UIKit

class ProfilePageView: UIView {
  
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .green
    imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    imageView.layer.cornerRadius = 100
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let profileNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Aji Saputra Raka Siwi"
    label.textAlignment = .center
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
    
    self.scrollView.addSubview(self.profileImageView)
    self.profileImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 16).isActive = true
    self.profileImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
    self.profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    self.profileImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    self.scrollView.addSubview(self.profileNameLabel)
    self.profileNameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 16).isActive = true
    self.profileNameLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 16).isActive = true
    self.profileNameLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -16).isActive = true
    self.profileNameLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -16).isActive = true
    self.profileNameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
