//  Ultravisual

import UIKit

struct Destination {
  var name: String
  var backgroundImage: UIImage
  
  init?(dictionary: [String: String]) {
    guard
      let name = dictionary["Name"],
      let backgroundName = dictionary["Background"],
      let backgroundImage = UIImage(named: backgroundName)
    else {
      return nil
    }
    
    self.name = name
    self.backgroundImage = backgroundImage
  }
  
  static func allDestinations() -> [Destination] {
    var allDestinations: [Destination] = []
    
    guard
      let URL = Bundle.main.url(forResource: "Destinations", withExtension: "plist"),
      let destinationsPlist = NSArray(contentsOf: URL) as? [[String: String]]
    else {
      return allDestinations
    }
    
    for dictionary in destinationsPlist {
      if let destination = Destination(dictionary: dictionary) {
        allDestinations.append(destination)
      }
    }
    return allDestinations
  }
}
