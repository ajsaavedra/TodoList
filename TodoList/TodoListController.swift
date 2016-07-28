import UIKit
import CoreData

class TodoListController: UITableViewController, NSFetchedResultsControllerDelegate {

    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView)
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            guard let destinationController = segue.destinationViewController as? DetailViewController, indexPath = tableView.indexPathForSelectedRow else { return }
            let item = dataSource.objectAtIndexPath(indexPath) as! Item
            destinationController.item = item
        }
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let item = dataSource.objectAtIndexPath(indexPath) as! Item

        let delete = UITableViewRowAction(style: .Destructive, title: "Delete") { (action, indexPath) in
            self.dataSource.deleteItem(tableView, forRowAtIndexPath: indexPath)
        }

        let share = UITableViewRowAction(style: .Normal, title: "Completed") { (action, indexPath) in
            item.completed = true
            DataController.sharedInstance.saveContext()
        }

        share.backgroundColor = UIColor.orangeColor()

        if item.completed {
            return [delete]
        } else {
            return [delete, share]
        }
    }
}