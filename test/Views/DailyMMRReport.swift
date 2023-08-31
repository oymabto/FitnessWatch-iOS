//
//  MMRReport.swift
//  test
//
//  Created by david on 2023-08-19.
//

import Foundation
import RealmSwift

class DailyMMRReport : Object, Identifiable{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var dateTime: Date = Date()
    @Persisted var isConfirmed: Bool = false
    @Persisted var ownerId: String = "registered user"
    
    
    func dateString() -> String {
        let array =  formatDate(date: self.dateTime).split(separator: ",")
        if let first = array.first {
            return String(first)
        }
        return ""
    }
    
    convenience init(dateTime: Date, isConfirmed: Bool, ownerId: String = "registered user") {
        self.init()
        self.dateTime = dateTime
        self.isConfirmed = isConfirmed
        self.ownerId = ownerId
    }
    

    static var mockList: [DailyMMRReport] {
        [
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-11 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-12 12:35"), isConfirmed: Bool.random()),
            DailyMMRReport(dateTime: parseDate("2023-08-13 12:35"), isConfirmed: Bool.random()),
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

