//
//  PackListModel.swift
//  iw2Pack
//
//  Created by Don McKenzie on 21-Jan-22.
//

import Foundation

struct PackListModel {
    let packList: PackList
    
    var itemId: String {
        packList.id ?? ""
    }
    
    var name: String {
        packList.name ?? ""
    }
}

