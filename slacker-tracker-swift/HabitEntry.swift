import Foundation
import RealmSwift

class HabitEntry: Object {
  dynamic var id = UUID().uuidString
  dynamic var owner: Habit? = nil
  dynamic var createdAt: Date = Date()
  dynamic var notes: String? = nil
  
  override class func primaryKey() -> String {
    return "id"
  }
}
