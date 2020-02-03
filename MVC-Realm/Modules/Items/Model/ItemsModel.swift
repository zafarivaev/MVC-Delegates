//
//  ItemsModel.swift
//  MVC-Realm
//
//  Created by Zafar on 2/2/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RealmSwift

class ItemsModel {
    
    weak var controller: ItemsModelOutput?
    
    private var items: Results<Item>?
    private var realm = try! Realm()
}

// MARK: - Controller Input
extension ItemsModel: ItemsControllerInput {
    
    func retrieveItems() {
        print("Controller tells the Model to retrieve items")
        self.items = realm.objects(Item.self)
        controller?.onItemsRetrieval(self.items!)
    }
    
    func addItem(title: String) {
        print("Controller tells the Model to add an item with title \(title)")
        let item = Item(title: title)
        do {
            try self.realm.write {
                self.realm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
        controller?.onItemAddition(item: item)
    }
    
    func deleteItem(at index: Int) {
        print("Controller tells the Model to delete an item at the index \(index)")
        if let items = items {
            do {
                try self.realm.write {
                    self.realm.delete(items[index])
                }
            } catch {
                print("Couldn't delete")
            }
            controller?.onItemDeletion(index: index)
        }
    }
    
    func retrieveItemUUID(for index: Int) {
        print("Controller tells the Model to retrieve an UUID of an item at the index \(index)")
        let itemUUID = self.items![index].id
        controller?.onUUIDRetrieval(uuid: itemUUID)
    }
    
}
