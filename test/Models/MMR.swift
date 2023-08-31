//
//  MMR.swift
//  Test
//
//  Created by Alireza on 2023-08-10.
//

import Foundation
import SwiftUI
import RealmSwift

class MMR: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var profileId: String = ""
    @Persisted var isEnabled: Bool = false
    @Persisted var notificationFrequency: Int = 0
    @Persisted var maxAllowedIgnores: Int = 0
    }
