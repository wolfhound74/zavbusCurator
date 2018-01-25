import UIKit

class BusTrip {

    var name: String?
    var dates: String?

    var records = [TripRecord]()
    var programs = [BusTripProgram]()

    init(name: String, dates: String) {
        self.name = name
        self.dates = dates
    }

    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "title") as? String
        self.dates = dictionary.object(forKey: "dates") as? String

        let recs = dictionary.object(forKey: "records") as! Array<NSDictionary>

        for var recDictionary in recs {
            records.append(TripRecord(dictionary: recDictionary))
        }
    }

    func addRecord(rec: TripRecord) {
        records.append(rec)
    }

    func addProgram(program: BusTripProgram) {
        programs.append(program)
    }
}
