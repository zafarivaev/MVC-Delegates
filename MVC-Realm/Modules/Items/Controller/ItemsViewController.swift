//
//  ViewController.swift
//  MVC-Realm
//
//  Created by Zafar on 1/28/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = itemsView as? UIView
    }

    // MARK: - Properties
    var itemsView: ItemsControllerOutput?
    var itemsModel: ItemsControllerInput?
}

// MARK: - View Input
extension ItemsViewController: ItemsViewInput {
    func onViewLayout() {
        print("View tells Controller it is has been setup")
        itemsModel?.retrieveItems()
    }
    
    func onAddTap(alert: UIAlertController) {
        print("View tells Controller the Add button was tapped")
        self.present(alert, animated: true, completion: nil)
    }
    
    func onSaveTap(title: String) {
        print("View tells Controller the Save button was tapped")
        itemsModel?.addItem(title: title)
    }
    
    func onDeleteSelection(index: Int) {
        print("View tells Controller the Delete action was selected")
        itemsModel?.deleteItem(at: index)
    }
    
    func onCellSelection(index: Int) {
        print("View tells Controller a cell was selected at index: \(index)")
        itemsModel?.retrieveItemUUID(for: index)
    }
}

// MARK: - Model Output
extension ItemsViewController: ItemsModelOutput {
    func onItemsRetrieval(_ items: Results<Item>) {
        print("Controller gets the result from Model, transforms it into a displayable format, then forwards it to the View")
        let titles: [String]? = items
            .compactMap { $0.title }
        itemsView?.onItemsRetrieval(titles: titles ?? [])
    }
    
    func onItemAddition(item: Item) {
        print("Controller gets the result from Model, transforms it into a displayable format, then forwards it to the View")
        itemsView?.onItemAddition(title: item.title)
    }

    func onItemDeletion(index: Int) {
        print("Controller gets the result from Model, then forwards it to the View")
        itemsView?.onItemDeletion(index: index)
    }
    
    func onUUIDRetrieval(uuid: String) {
        print("Controller gets the result from Model, builds up a new module, then navigates to it passing in the UUID of the selected item")
        let controller = ItemDetailController()
        let view = ItemDetailView()
        let model = ItemDetailModel()
        
        controller.itemDetailView = view
        controller.itemDetailView?.controller = controller
        controller.itemDetailModel = model
        controller.itemDetailModel?.controller = controller
        
        model.itemUUID = uuid
        
        self.navigationController?
            .pushViewController(controller, animated: true)
    }
    
}
