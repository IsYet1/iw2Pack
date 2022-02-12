//
//  ItemViewModel.swift
//  iw2Pack
//
//  Created by Don McKenzie on 18-Jan-22.
//

import Foundation

struct ItemViewModel {
    let item: Item
    
    var itemId: String {
        item.id ?? ""
    }
    
    var name: String {
        item.name ?? ""
    }
     
    var itemIdId: String {
        item.itemId ?? ""
    }

    var packed: Bool {
        item.packed ?? false
    }
    
    var staged: Bool {
        item.staged ?? false
    }
}

