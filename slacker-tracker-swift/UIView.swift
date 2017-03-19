import UIKit

extension UIView {
  
  func addChildViewAndConstrainToBounds(childView: UIView, insets: UIEdgeInsets? = nil) {
    childView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(childView)
    childView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets?.left ?? 0).isActive = true
    childView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets?.right ?? 0).isActive = true
    childView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets?.top ?? 0).isActive = true
    childView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets?.bottom ?? 0).isActive = true
  }
  
}
