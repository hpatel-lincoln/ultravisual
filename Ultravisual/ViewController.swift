//  Ultravisual

import UIKit

class ViewController: UIViewController {
  
  let destinations = Destination.allDestinations()
  
  @IBOutlet var collectionView: UICollectionView!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    
    collectionView.dataSource = self
    collectionView.backgroundColor = UIColor.clear
    collectionView.decelerationRate = .fast
    collectionView.contentInsetAdjustmentBehavior = .never
  }
}

extension ViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return destinations.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UltravisualCell.self)", for: indexPath) as! UltravisualCell
    cell.destination = destinations[indexPath.item]
    return cell
  }
}
