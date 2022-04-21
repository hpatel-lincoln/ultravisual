//  Ultravisual

import UIKit

struct UltravisualCellConstants {
  static let FeaturedHeight: CGFloat = 280
  static let StandardHeight: CGFloat = 100
}

class UltravisualCell: UICollectionViewCell {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var imageCoverView: UIView!
  @IBOutlet var nameLabel: UILabel!
  
  var destination: Destination? {
    didSet {
      updateUI()
    }
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    let featuredHeight = UltravisualCellConstants.FeaturedHeight
    let standardHeight = UltravisualCellConstants.StandardHeight
    
    let nextItemPercentOffset = 1 - (featuredHeight - frame.height)/(featuredHeight - standardHeight)
    let maxAlpha: CGFloat = 0.75
    let minAlpha: CGFloat = 0.3
    
    let nextItemAlphaOffset = (maxAlpha - minAlpha) * nextItemPercentOffset
    imageCoverView.alpha = maxAlpha - nextItemAlphaOffset
    
    let scale = max(nextItemPercentOffset, 0.5)
    nameLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
  }
  
  private func updateUI() {
    guard let destination = destination else {
      return
    }
    
    imageView.image = destination.backgroundImage
    nameLabel.text = destination.name
  }
}
