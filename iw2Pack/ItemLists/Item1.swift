//
//  Item1.swift
//  iw2Pack
//
//  Created by Don McKenzie on 12-Feb-22.
//

import Foundation

struct Item1: Hashable {
    init(id: String, name: String, packed: Bool, itemId: String) {
        self.id = id
        self.name = name
        self.itemId = itemId
        self.packed = packed
    }
    
    var id: String?
    var name: String?
    var itemId: String?
    var packed: Bool?
    var staged: Bool?
}

