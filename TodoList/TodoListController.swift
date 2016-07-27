import UIKit
import CoreData

class TodoListController: UITableViewController, NSFetchedResultsControllerDelegate {

    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            guard let destinationController = segue.destinationViewController as? DetailViewController, indexPath = tableView.indexPathForSelectedRow else { return }
            let item = dataSource.objectAtIndexPath(indexPath) as! Item
            destinationController.item = item
        }
    }
}