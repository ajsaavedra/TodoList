import UIKit
import CoreData

class TodoListController: UITableViewController, NSFetchedResultsControllerDelegate {

    let managedObjectContext = DataController.sharedInstance.managedObjectContext

    lazy var fetchedResultsController: TodoFetchedResultsController = {
        let controller = TodoFetchedResultsController(managedObjectContext: self.managedObjectContext,
                                                      withTableView: self.tableView)
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return configureCell(cell, atIndexPath: indexPath)
    }

    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(item)
        DataController.sharedInstance.saveContext()
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
}