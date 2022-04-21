//  Ultravisual

import UIKit

class UltravisualLayout: UICollectionViewLayout {
  
  private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
  
  // The collection view width
  var width: CGFloat {
    collectionView!.bounds.width
  }
  
  // The collection view height
  var height: CGFloat {
    collectionView!.bounds.height
  }
  
  // The number of items in collection view (only first section is considered)
  var numOfItems: Int {
    collectionView!.numberOfItems(inSection: 0)
  }
  
  // The amount to scroll before the featured item changes
  var scrollOffset: CGFloat {
    return UltravisualCellConstants.FeaturedHeight
    - UltravisualCellConstants.StandardHeight
  }
    
  // The index of the featured item
  var featuredItemIndex: Int {
    max(Int(collectionView!.contentOffset.y/scrollOffset), 0)
  }
  
  // Returns a value between 0 and 1 indicating how close the next item is to becoming the featured cell
  var nextItemPercentOffset: CGFloat {
    max((collectionView!.contentOffset.y/scrollOffset), 0) - CGFloat(featuredItemIndex)
  }
  
  // Returns the size of all the content in the collection view
  override var collectionViewContentSize: CGSize {
    let contentHeight = (scrollOffset * CGFloat(numOfItems-1)) + height
    return CGSize(width: width, height: contentHeight)
  }
  
  override func prepare() {
    super.prepare()
    
    cachedAttributes.removeAll()
    
    let featuredHeight = UltravisualCellConstants.FeaturedHeight
    let standardHeight = UltravisualCellConstants.StandardHeight
    var previousItemMaxY: CGFloat = 0
    
    for index in 0..<numOfItems {
      var y: CGFloat = previousItemMaxY
      var cellHeight: CGFloat = standardHeight
      
      if index == featuredItemIndex {
        cellHeight = featuredHeight
        let yOffset = standardHeight * nextItemPercentOffset
        y = collectionView!.contentOffset.y - yOffset
      } else if index == featuredItemIndex + 1 {
        cellHeight = standardHeight + (scrollOffset * nextItemPercentOffset)
        let maxY = previousItemMaxY + standardHeight
        y = maxY - cellHeight
      }
      
      let frame = CGRect(x: 0, y: y, width: width, height: cellHeight)
      let indexPath = IndexPath(item: index, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frame
      attributes.zIndex = indexPath.item
      
      cachedAttributes.append(attributes)
      
      previousItemMaxY = frame.maxY
    }
  }
  
  // Invalidate layout as the user scrolls
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    for attributes in cachedAttributes {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.item]
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    let index = round(proposedContentOffset.y/scrollOffset)
    let offset = index * scrollOffset
    return CGPoint(x: 0, y: offset)
  }
}
