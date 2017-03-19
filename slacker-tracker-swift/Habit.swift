import Foundation
import RealmSwift

class Habit: Object {
  dynamic var id: String = UUID().uuidString
  dynamic var title: String = ""
  dynamic var color: String? = nil
  dynamic var goalPeriod: Date?
  dynamic var goalCount: Int = 0
  dynamic var createdAt: Date = Date()
  
  
  override class func primaryKey() -> String {
    return "id"
  }
}
