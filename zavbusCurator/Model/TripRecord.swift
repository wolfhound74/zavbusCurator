import UIKit

class TripRecord {
    var id: Int?

    var firstName: String?
    var lastName: String?

    var needStuff: Bool?
    var needMeal: Bool?

    var availableBonuses: Int?
    var usedBonuses: Int?
    var paidSum: Int?

    var neededSum: Int?

    var trip: BusTrip?

    var fullName: String {
        return "\(lastName!) \(firstName!)"
    }

    init(fn: String, ln: String) {
        self.firstName = fn
        self.lastName = ln
    }

    init(dictionary: NSDictionary) {
        self.firstName = dictionary.object(forKey: "firstName") as! String
        self.lastName = dictionary.object(forKey: "lastName") as! String
        self.paidSum = 0
    }
}
