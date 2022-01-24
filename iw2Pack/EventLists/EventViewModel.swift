//
//  EventViewModel.swift
//  iw2Pack
//
//  Created by Don McKenzie on 24-Jan-22.
//

import Foundation

struct EventViewModel {
    let event: Event
    
    var eventId: String {
        event.id ?? ""
    }
    var name: String {
        event.name ?? ""
    }
    var stage: Bool {
        event.stage ?? false
    }
}
