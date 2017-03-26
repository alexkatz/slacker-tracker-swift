import UIKit

class AddHabitNameCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "AddHabitNameCollectionViewCell"
  static let nib = UINib(nibName: "AddHabitNameCollectionViewCell", bundle: nil)
  
  @IBOutlet weak var nameTextField: UITextField!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    nameTextField.placeholder = "Habit name..."
  }
  
}
