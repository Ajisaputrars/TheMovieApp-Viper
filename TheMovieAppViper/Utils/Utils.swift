//
//  DateFormatter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 03/02/21.
//

import UIKit

class Utils {
  static func changeDateStringIntoFormattedString(withStringDate dateString: String,
                                                  locale: String = "id_ID") -> String {
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "YYYY-MM-dd"
    let date = formatter1.date(from: dateString)
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "dd MMMM YYYY"
    formatter2.locale = Locale(identifier: locale)
    return formatter2.string(from: date ?? Date())
  }
  
  static func showAlert(in controller: UIViewController, title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    controller.present(alertController, animated: true, completion: nil)
  }
  
  static func getApiKey() -> String {
    guard let path = Bundle.main.path(forResource: "ApiKey", ofType: "plist") else {
      fatalError("Couldn't find file 'API-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: path)
    guard let value = plist?.object(forKey: "apiKey") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'API-Info.plist'.")
    }
    return value
  }
}
