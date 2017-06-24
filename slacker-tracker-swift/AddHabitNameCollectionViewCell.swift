import UIKit
import SnapKit

class AddHabitNameCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "AddHabitNameCollectionViewCell"
  
  var nameTextField: UITextField!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  func initialize() {
    nameTextField = UITextField()
    nameTextField.borderStyle = .roundedRect
    contentView.addSubview(nameTextField)
    nameTextField.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(UIEdgeInsetsMake(Constants.padding, Constants.padding, Constants.padding, Constants.padding))
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    nameTextField.placeholder = "Habit name..."
  }
  
}
