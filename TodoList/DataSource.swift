import Foundation
import UIKit
import CoreData

class DataSource: NSObject, UITableViewDataSource {

    private let tableView: UITableView

    let managedObjectContext = DataController.sharedInstance.managedObjectContext

    lazy var fetchedResultsController: TodoFetchedResultsController = {
        let controller = TodoFetchedResultsController(managedObjectContext: self.managedObjectContext,
                                                      withTableView: self.tableView)
        return controller
    }()

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func objectAtIndexPath(indexPath: NSIndexPath) -> NSManagedObject {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
    }

    func deleteItem(tableView: UITableView, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(item)
        DataController.sharedInstance.saveContext()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return configureCell(cell, atIndexPath: indexPath)
    }

    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
}