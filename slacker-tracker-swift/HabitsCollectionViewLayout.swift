import UIKit

class HabitsCollectionViewLayout: UICollectionViewFlowLayout {
  
  private var dynamicAnimator: UIDynamicAnimator!
  private var visibleIndexPathSet = Set<IndexPath>()
  private var latestDelta = CGFloat(0)
  
  override init() {
    super.init()
    dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    minimumInteritemSpacing = Constants.padding
    minimumLineSpacing = Constants.padding
    itemSize = CGSize(width: UIScreen.main.bounds.width - (Constants.padding * 2), height: 120)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else { return }
    let breathingRoom = CGFloat(100)
    let visibleRect = CGRect(
      origin: CGPoint(
        x: collectionView.bounds.origin.x,
        y: collectionView.bounds.origin.y - breathingRoom),
      size: CGSize(
        width: collectionView.frame.size.width,
        height: collectionView.frame.size.height + (2 * breathingRoom)
      )
    )
    if let visibleLayoutAttributes = super.layoutAttributesForElements(in: visibleRect) {
      let noLongerVisibleBehaviors = dynamicAnimator.behaviors.filter { behavior in
        if let attachmentBehavior = behavior as? UIAttachmentBehavior, let attributesItem = attachmentBehavior.items.first as? UICollectionViewLayoutAttributes {
          return !visibleIndexPathSet.contains(attributesItem.indexPath)
        }
        return true
      }
      
      for springBehavior in noLongerVisibleBehaviors.map({ $0 as! UIAttachmentBehavior }) {
        dynamicAnimator.removeBehavior(springBehavior)
        visibleIndexPathSet.remove((springBehavior.items.last! as! UICollectionViewLayoutAttributes).indexPath)
      }
      
      let newVisibleLayoutAttributes = visibleLayoutAttributes.filter { !visibleIndexPathSet.contains($0.indexPath) }
      let touchLocation = collectionView.panGestureRecognizer.location(in: collectionView)
      
      for attributesItem in newVisibleLayoutAttributes {
        var center = attributesItem.center
        let springBehavior = UIAttachmentBehavior(item: attributesItem, attachedToAnchor: center)
        springBehavior.length = 0
        springBehavior.damping = 0.6
        springBehavior.frequency = 1
        if !touchLocation.equalTo(CGPoint.zero) {
          let distanceFromTouch = touchLocation.y - springBehavior.anchorPoint.y
          let scrollResistance = getScrollResistance(distanceFromTouch: distanceFromTouch)
          if latestDelta < 0 {
            center.y += max(latestDelta, latestDelta * scrollResistance)
          } else {
            center.y += min(latestDelta, latestDelta * scrollResistance)
          }
          attributesItem.center = center
          dynamicAnimator.addBehavior(springBehavior)
          visibleIndexPathSet.insert(attributesItem.indexPath)
        }
      }
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return dynamicAnimator.items(in: rect).map { $0 as! UICollectionViewLayoutAttributes }
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return dynamicAnimator.layoutAttributesForCell(at: indexPath)
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionView = collectionView else { return false }
    let delta = newBounds.origin.y - collectionView.bounds.origin.y
    let touchLocation = collectionView.panGestureRecognizer.location(in: collectionView)
    for springBehavior in dynamicAnimator.behaviors.map({ $0 as! UIAttachmentBehavior }) {
      let distanceFromTouch = touchLocation.y - springBehavior.anchorPoint.y
      let scrollResistance = getScrollResistance(distanceFromTouch: distanceFromTouch)
      if let attributesItem = springBehavior.items.first {
        var center = attributesItem.center
        if delta < 0 {
          center.y += max(delta, delta * scrollResistance)
        } else {
          center.y += min(delta, delta * scrollResistance)
        }
        attributesItem.center = center
        dynamicAnimator.updateItem(usingCurrentState: attributesItem)
      }
    }
    latestDelta = delta
    return false
  }
  
  private func getScrollResistance(distanceFromTouch: CGFloat) -> CGFloat { return distanceFromTouch / 1300 }
  
}
