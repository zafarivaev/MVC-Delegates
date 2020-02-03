//
//  ItemDetailContract.swift
//  MVC-Realm
//
//  Created by Zafar on 2/2/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import RealmSwift

/// *View* sends user actions to the *Controller*
///
/// **Controller** conforms to this protocol
protocol ItemDetailViewInput: class {
    
    var itemDetailView: ItemDetailControllerOutput? { get set }
    var itemDetailModel: ItemDetailControllerInput? { get set }
    
    func onViewLayout()
}

/// *Controller* tells *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol ItemDetailControllerInput: class {
    
    var controller: ItemDetailModelOutput? { get set }
    
    func retrieveItem()
}

/// *Model* returns the result to *Controller*
///
/// **Controller** conforms to this protocol
protocol ItemDetailModelOutput: class {
    func onItemRetrieval(item: Item)
}

/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol ItemDetailControllerOutput: class {
    
    var controller: ItemDetailViewInput? { get set }
    
    func onItemRetrieval(title: String)
}
