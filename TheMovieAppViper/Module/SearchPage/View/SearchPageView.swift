import UIKit

class SearchPageView: UIView {
  
  let movieSearchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()
  
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
    tableView.showsVerticalScrollIndicator = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  let noDataLabel: UILabel = {
    let label = UILabel()
    label.text = "No Data"
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func setupLoadingView(isLoading: Bool) {
    self.noDataLabel.isHidden = true
    self.movieTableView.isHidden = isLoading
    self.loadingLabel.isHidden = !isLoading
    self.loadingIndicatorView.isHidden = !isLoading
    if isLoading {
      self.loadingIndicatorView.startAnimating()
    } else {
      self.loadingIndicatorView.stopAnimating()
    }
  }
  
  func setupNoDataState() {
    self.noDataLabel.isHidden = false
    self.movieTableView.isHidden = true
    self.loadingLabel.isHidden = true
    self.loadingIndicatorView.isHidden = true
    self.loadingIndicatorView.stopAnimating()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }
  
  private func setupView() {
    self.backgroundColor = .white
    
    self.addSubview(movieSearchBar)
    movieSearchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
    movieSearchBar.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
    movieSearchBar.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
    
    self.addSubview(noDataLabel)
    noDataLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    noDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    self.addSubview(self.movieTableView)
    self.movieTableView.topAnchor.constraint(equalTo: self.movieSearchBar.bottomAnchor, constant: -1).isActive = true
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
