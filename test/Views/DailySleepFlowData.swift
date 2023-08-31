//
//  DailySleepFlowData.swift
//  test
//
//  Created by david on 2023-08-19.
//

import Foundation

import Foundation
import RealmSwift

class DailySleepFlowData : Object, Identifiable{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var bedTimeDateTime: Date = Date()
    @Persisted var riseDateTime: Date = Date()

    @Persisted var isRested: Bool = false
    @Persisted var ownerId: String = "registered user"
    
    func sleepOverTime() -> Double {
        let timeInterval = riseDateTime.timeIntervalSince(bedTimeDateTime)
        return timeInterval / 3600  // Convert seconds to hours
    }
    
    func dateString() -> String {
        let array =  formatDate(date: self.bedTimeDateTime).split(separator: ",")
        if let first = array.first {
            return String(first)
        }
        return ""
    }
    
    convenience init(bedTimeDateTime: Date, riseDateTime: Date, isRested: Bool, ownerId: String = "registered user") {
        self.init()
        self.bedTimeDateTime = bedTimeDateTime
        self.riseDateTime = riseDateTime
        self.isRested = isRested
        self.ownerId = ownerId
    }
    

    static var mockList: [DailySleepFlowData] {
        [
            DailySleepFlowData(bedTimeDateTime: parseDate("2023-08-15 23:15"), riseDateTime: parseDate("2023-08-16 06:36"), isRested: Bool.random()),
            DailySleepFlowData(bedTimeDateTime: parseDate("2023-08-16 23:15"), riseDateTime: parseDate("2023-08-17 05:36"), isRested: Bool.random()),
            DailySleepFlowData(bedTimeDateTime: parseDate("2023-08-17 23:15"), riseDateTime: parseDate("2023-08-18 04:36"), isRested: Bool.random()),
            DailySleepFlowData(bedTimeDateTime: parseDate("2023-08-18 23:15"), riseDateTime: parseDate("2023-08-19 06:06"), isRested: Bool.random()),
        ]
    }
    
    
    static func parseDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()
    }

    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .none
        return dateFormatter.string(from: date)
    }

}

