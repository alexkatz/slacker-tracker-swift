import UIKit

class HabitsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Constants.whiteColor
    
    title = "Habits"
    navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddHabitView)), animated: false)

    let layout = HabitsCollectionViewLayout()
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsetsMake(Constants.padding, 0, 0, 0)
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
     make.edges.equalToSuperview()
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
    
    cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func showAddHabitView() {
    
    let addHabitViewController = UINavigationController(rootViewController: AddHabitViewController())
    self.present(addHabitViewController, animated: true)
  }

}

