import UIKit
import SQLite

class BusTripTableViewController: UITableViewController {

    var trips = [BusTrip]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let t = UserDefaults.standard.object(forKey: "trips") {
            trips = t as! [BusTrip]
        } else {
            self.getDataFromServer()
        }

        prepareStorage()
        self.tableView.reloadData()
    }

    private func prepareStorage() {

        do {
            let databaseFileName = "dbtest.sqlite3"
            let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
            let db = try Connection(databaseFilePath)


            let trips = Table("trips")
            let id = Expression<Int64>("id")
            let name = Expression<String?>("name")
            let email = Expression<String>("email")

            try db.run(trips.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            })

//            let fm = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//            let fileUrl = try fm.appendingPathComponent("trips").appendPathExtension("sqlite3")
//            let db = try Connection()
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }

    @IBAction func pullTripButton(_ sender: Any) {
        let alert = UIAlertController(
                title: "Список выездов",
                message: "Забрать данные с сервера?",
                preferredStyle: .alert)

        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "username"
        }
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "пароль"
        }

        let defaultAction = UIAlertAction(title: "Скачать", style: .default) { (alert) in
            self.getDataFromServer()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { (alert) in
            print("cancel")
        }
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        self.present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)

        cell.textLabel?.text = trips[indexPath.row].name
        cell.detailTextLabel?.text = trips[indexPath.row].dates

        return cell
    }

    private func getDataFromServer() {
//        let url = URL(string: "http://zavbus.team/api/curatorData")
        let url = URL(string: "http://localhost:8090/api/curatorData")
        do {
            let data = try Data(contentsOf: url!)
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                let loadTrips = dict.object(forKey: "trips") as! Array<NSDictionary>
                for var trip in loadTrips {
                    trips.append(BusTrip(dictionary: trip))
                }
            } catch {
            }
        } catch {
        }

//        UserDefaults.standard.set(self.trips, forKey: "trips")
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tripRecords" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let records = trips[indexPath.row].records
                let controller = segue.destination as! TripRecordTableViewController
                controller.records = records
                controller.trip = trips[(tableView.indexPathForSelectedRow?.row)!]

                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }


}
