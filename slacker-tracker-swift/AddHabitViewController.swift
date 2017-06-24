import UIKit

class AddHabitViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var collectionView: UICollectionView!
  
  let containerView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Constants.whiteColor
    
    title = "Add Habit"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveHabit))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeWithoutSaving))
    
    
    view.addSubview(containerView)
    containerView.backgroundColor = UIColor.orange
    containerView.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    
    let layout = HabitsCollectionViewLayout(cellHeight: Constants.HabitCellHeight / 2)
    layout.minimumLineSpacing = 0
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.register(AddHabitNameCollectionViewCell.self, forCellWithReuseIdentifier: AddHabitNameCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    
    containerView.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func saveHabit() {
    
  }
  
  func closeWithoutSaving() {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddHabitNameCollectionViewCell.identifier, for: indexPath) as! AddHabitNameCollectionViewCell
    
    cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
}
