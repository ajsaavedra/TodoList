import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    let dataController = DataController.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func save(sender: AnyObject) {
        guard let text = textField.text else { return }
        let item = NSEntityDescription.insertNewObjectForEntityForName(Item.identifier,
                    inManagedObjectContext: dataController.managedObjectContext) as! Item
        item.text = text
        dataController.saveContext()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

