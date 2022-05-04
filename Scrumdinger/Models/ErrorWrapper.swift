//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by nexsoft nexsoft on 28/04/22.
//

import Foundation

struct ErrorWrapper: Identifiable{
    var id: UUID
    var error: Error
    var guidance: String
    
    init(id: UUID = UUID(), error:  Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
