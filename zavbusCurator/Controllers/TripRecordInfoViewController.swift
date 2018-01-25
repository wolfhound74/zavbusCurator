import UIKit

class TripRecordInfoViewController: UIViewController {

    @IBOutlet weak var needPay: UILabel!
    @IBOutlet weak var riderFullName: UILabel!
    var record: TripRecord?

    var needPaySum: Int?
    var startSum: Int?

    @IBAction func statusSegment(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            needPaySum = 950 + startSum!
        } else if sender.selectedSegmentIndex == 1 {
            needPaySum = 650 + startSum!
        } else {
            needPaySum = startSum!
        }

        reloadViewData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startSum = 850
        needPaySum = startSum

        reloadViewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func reloadViewData() {
        riderFullName.text = record?.fullName
        needPay.text = "\(needPaySum! - (record?.paidSum)!)"
    }

}
