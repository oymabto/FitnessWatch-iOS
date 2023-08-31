//
//  Sleep.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import RealmSwift

class Sleep: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var bedTime: Date = Date()
    @Persisted var riseTime: Date = Date()
    @Persisted var isRestfulCycle: Bool = true
    
    func getDuration(bedTime: Date, riseTime: Date) -> Int {
        // TODO: Implement the logic
        return 0
    }
}

