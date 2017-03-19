import UIKit

class HabitsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  var collectionView: UICollectionView!
  var titleBarView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
    
    titleBarView = UIView()
    
    
    let layout = HabitsCollectionViewLayout()
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsets(top: Constants.padding, left: 0, bottom: Constants.padding, right: 0)
    view.addChildViewAndConstrainToBounds(childView: collectionView)
  }
  
  override var prefersStatusBarHidden: Bool { return true }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
    
    cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

}

