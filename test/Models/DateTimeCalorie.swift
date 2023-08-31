//
//  DateTimeCalorie.swift
//  test
//
//  Created by david on 2023-08-14.
//

import DGCharts
import Foundation
import RealmSwift

class DateTimeCalorie : Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var dateTime: Date = Date()
    @Persisted var calories: Double = 50.0
    @Persisted var foodText: String? = nil
    @Persisted var imageUrl: String? = nil
    
    convenience init(dateTime: Date, calories: Double) {
        self.init()
        self.dateTime = dateTime
        self.calories = calories
    }
    
    static func daysString() -> [String] {
        return self.dataEntries(self.mockListOfDateTimeCalorie).map { entry in
            if let formattedDay = dayOfYearToString(Int(entry.x)) {
                return formattedDay
            } else {
                return "Invalid day"
            }
        }
    }
    
    static func dataEntries(_ dateTimeCalories: [DateTimeCalorie]) -> [BarChartDataEntry] {
        var aggregatedData: [String: Double] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for dateTimeCalorie in dateTimeCalories {

            let dateString = dateFormatter.string(from: dateTimeCalorie.dateTime)
            
            if let existingCalorie = aggregatedData[dateString] {
                aggregatedData[dateString] = existingCalorie + dateTimeCalorie.calories
            } else {
                aggregatedData[dateString] = dateTimeCalorie.calories
            }
        }
        
        let calendar = Calendar.current
        return aggregatedData.map { BarChartDataEntry(x: Double(calendar.ordinality(of: .day, in: .year, for: dateFormatter.date(from: $0.key)!) ?? 1), y: $0.value) }
    }
    
    static var mockListOfDateTimeCalorie: [DateTimeCalorie] {
        [
            DateTimeCalorie(dateTime: parseDate("2023-08-3 07:30"), calories: 1200.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-4 07:30"), calories: 1200.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-5 07:30"), calories: 1600.0),
            DateTimeCalorie(dateTime: parseDate("2023-08-6 07:30"), calories: 2600.0),
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
    
    static func dayOfYearToString(_ dayOfYear: Int) -> String? {
        guard dayOfYear >= 1 && dayOfYear <= 366 else {
            return nil
        }
        
        let dateComponents = DateComponents(year: Calendar.current.component(.year, from: Date()), day: dayOfYear)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        if let date = Calendar.current.date(from: dateComponents) {
            let dayFormatter = NumberFormatter()
            dayFormatter.numberStyle = .ordinal
            if let day = dayFormatter.string(from: dayOfYear as NSNumber) {
                return dateFormatter.string(from: date) + " " + day
            }
        }
        
        return nil
    }

}

extension String {
    func toTimeInterval() -> TimeInterval {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date.timeIntervalSince1970
        }
        return 0
    }
}
