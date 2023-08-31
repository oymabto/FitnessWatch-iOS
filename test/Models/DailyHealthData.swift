//
//  DailyHealthData.swift
//  test
//
//  Created by david on 2023-08-15.
//

import DGCharts
import Foundation
import RealmSwift

class DailyHealthData : Object, Identifiable{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var dateTime: Date = Date()

    @Persisted var value: Double = 50.0
    @Persisted var type: String = "weight"
    @Persisted var ownerId: String = "registered user"
    
    func dateString() -> String {
        let array =  formatDate(date: self.dateTime).split(separator: ",")
        if let first = array.first {
            return String(first)
        }
        return ""
    }
    
    convenience init(dateTime: Date, type: String, value: Double, ownerId: String = "registered user") {
        self.init()
        self.dateTime = dateTime
        self.value = value
        self.type = type
        self.ownerId = ownerId
    }
    
    static let WEIGHT = "weight"
    static let RESTING_HEART_RATE = "restingHeartRate"
    static let BLOOD_PRESSURE = "bloodPressure"
    

    static var mockListOfDailyHealthData: [DailyHealthData] {
        [
            DailyHealthData(dateTime: parseDate("2023-08-3"), type: DailyHealthData.WEIGHT, value: 50.0),
            DailyHealthData(dateTime: parseDate("2023-08-3"), type: DailyHealthData.RESTING_HEART_RATE, value: 60.0),
            DailyHealthData(dateTime: parseDate("2023-08-3"), type: DailyHealthData.BLOOD_PRESSURE, value: 110.0),
            
            DailyHealthData(dateTime: parseDate("2023-08-4"), type: "weight", value: 49.5),
            DailyHealthData(dateTime: parseDate("2023-08-4"), type: "restingHeartRate", value: 56.0),
            DailyHealthData(dateTime: parseDate("2023-08-4"), type: "bloodPressure", value: 106.0),
            
            DailyHealthData(dateTime: parseDate("2023-08-5"), type: "weight", value: 51.0),
            DailyHealthData(dateTime: parseDate("2023-08-5"), type: "restingHeartRate", value: 63.0),
            DailyHealthData(dateTime: parseDate("2023-08-5"), type: "bloodPressure", value: 118.0),
        ]
    }
    
    static func parseDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
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

