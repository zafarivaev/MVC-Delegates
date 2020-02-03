//
//  ItemsContract.swift
//  MVC-Realm
//
//  Created by Zafar on 2/2/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import RealmSwift

/// *View* sends user actions to the *Controller*.
///
/// **Controller** conforms to this protocol
protocol ItemsViewInput: class {
    
    var itemsView: ItemsControllerOutput? { get set }
    var itemsModel: ItemsControllerInput? { get set }
    
    func onViewLayout()
    func onAddTap(alert: UIAlertController)
    func onSaveTap(title: String)
    func onDeleteSelection(index: Int)
    func onCellSelection(index: Int)
}

/// *Controller* tells the *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol ItemsControllerInput: class {
    
    var controller: ItemsModelOutput? { get set }
    
    func retrieveItems()
    func addItem(title: String)
    func deleteItem(at index: Int)
    func retrieveItemUUID(for index: Int)
}

/// *Model* returns the result to the *Controller*
///
/// **Controller** conforms to this protocol
protocol ItemsModelOutput: class {
    func onItemsRetrieval(_ items: Results<Item>)
    func onItemAddition(item: Item)
    func onItemDeletion(index: Int)
    func onUUIDRetrieval(uuid: String)
}

/// *Controller* returns a UI-representable result to the *View*
/// 
/// **View** conforms to this protocol
protocol ItemsControllerOutput: class {
    var controller: ItemsViewInput? { get set }
    
    func onItemsRetrieval(titles: [String])
    func onItemAddition(title: String)
    func onItemDeletion(index: Int)
}
