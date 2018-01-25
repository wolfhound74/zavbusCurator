//
//  TripRecordTableViewController.swift
//  zavbusCurator
//
//  Created by владимир on 24.01.2018.
//  Copyright © 2018 владимир. All rights reserved.
//

import UIKit

class TripRecordTableViewController: UITableViewController {

    var records = [TripRecord]()
    var trip: BusTrip?

    var selectedRider: TripRecord?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripRecordCell", for: indexPath)

        cell.textLabel?.text = self.records[indexPath.row].fullName
        return cell
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

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "recordInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let record = records[indexPath.row]
                let controller = segue.destination as! TripRecordInfoViewController

                controller.record = record
            }
        }
    }
}
