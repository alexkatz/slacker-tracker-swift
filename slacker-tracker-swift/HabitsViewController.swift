import UIKit

class HabitsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  var collectionView: UICollectionView!
  var headerView: UIView!
  var footerView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Constants.whiteColor

    let layout = HabitsCollectionViewLayout()
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.clear
    collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsets(top: Constants.headerHeight, left: 0, bottom: Constants.padding, right: 0)
    view.addChildViewAndConstrainToBounds(childView: collectionView)
    
    headerView = createHeaderView()
    headerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(headerView)
    headerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight).isActive = true
    headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
    footerView = createFooterView()
    footerView.translatesAutoresizingMaskIntoConstraints = false
    footerView.backgroundColor = UIColor.orange
    view.addSubview(footerView)
    footerView.heightAnchor.constraint(equalToConstant: Constants.footerHeight).isActive = true
    footerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    footerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
    
    cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func createHeaderView() -> UIView {
    let parentView = UIView()
    let titleLabel = UILabel()
    
    titleLabel.text = "Habits"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    parentView.addSubview(titleLabel)
    titleLabel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    
    return parentView
  }
  
  func createFooterView() -> UIStackView {
    let addButton = UIButton()
    addButton.setTitle("Add", for: .normal)
    addButton.setTitleColor(UIColor.black, for: .normal)
    addButton.addTarget(self, action: #selector(showAddHabitView), for: .touchUpInside)
    
    let parentView = UIStackView(arrangedSubviews: [addButton])
    parentView.axis = .horizontal
    parentView.distribution = .fillEqually
    
    return parentView
  }
  
  func showAddHabitView() {
    let addHabitViewController = AddHabitViewController()
    self.present(addHabitViewController, animated: true)
  }

}

