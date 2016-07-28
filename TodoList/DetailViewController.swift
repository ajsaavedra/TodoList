import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textfield: UITextField!
    var item: Item?

    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let item = item else { fatalError("Cannot show detail without an item") }
        self.textfield.delegate = self
        textfield.text = item.text
        navigationItem.title = item.text
    }

    @IBAction func update(sender: AnyObject) {
        if let item = item {
            item.text = textfield.text
            DataController.sharedInstance.saveContext()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return false
    }
}
