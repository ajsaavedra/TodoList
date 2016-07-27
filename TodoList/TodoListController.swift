import UIKit
import CoreData

class TodoListController: UITableViewController, NSFetchedResultsControllerDelegate {

    let managedObjectContext = DataController.sharedInstance.managedObjectContext

    lazy var fetchRequest: NSFetchRequest = {
        let request = NSFetchRequest(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()

    lazy var fetchedResultsController: NSFetchedResultsController = {
        let controller = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try self.fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
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

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}