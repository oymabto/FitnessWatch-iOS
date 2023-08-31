//
//  MMRReportViewModel.swift
//  test
//
//  Created by david on 2023-08-19.
//

import Foundation
import SwiftUI
import RealmSwift

//struct DailyMMRReportsBarData: Identifiable {
//    var id: ObjectId
//    var dateString: String = ""
//    var numberOfConfirms: Int = 0
//    var numberOfIgnores: Int = 0
//    var ownerId: String = "registered user"
//
//    init(dateString: String, numberOfConfirms: Int, numberOfIgnores: Int, ownerId: String) {
//        self.id = ObjectId()
//        self.dateString = dateString
//        self.numberOfConfirms = numberOfConfirms
//        self.numberOfIgnores = numberOfIgnores
//        self.ownerId = ownerId
//    }
//}

struct NumberOfMMR: Identifiable {
    let id = UUID()
    let dateString: String
    let number: Int
}

extension NumberOfMMR {
    static let confirms: [NumberOfMMR] = [
        .init(dateString: "Aug 1", number: 1),
        .init(dateString: "Aug 2", number: 0),
        .init(dateString: "Aug 3", number: 5),
    ]
    
    static let ignores: [NumberOfMMR] = [
        .init(dateString: "Aug 1", number: 1),
        .init(dateString: "Aug 2", number: 4),
        .init(dateString: "Aug 3", number: 5),
    ]
    
    static let total: [NumberOfMMR] = [
        .init(dateString: "Aug 1", number: 2),
        .init(dateString: "Aug 2", number: 4),
        .init(dateString: "Aug 3", number: 10)
    ]
}


class MMRReportViewModel: ObservableObject {
    private let realm = Repository.shared.realm
    
    @Published var tupleArray: [(numberType: String, data: [NumberOfMMR])] = []
    
    func initDataBase() {
        do {
            try realm.write {
                for item in DailyMMRReport.mockList {
                    realm.add(item)
                }
            }
        } catch {
            print(error)
        }
    }
    func getAll() {
        let dailyMMRReports = realm.objects(DailyMMRReport.self).sorted(byKeyPath: "dateTime", ascending: true)
        
        // Create a dictionary to store the aggregated number of confirmed and ignored MMRs per date
        var confirmsDict: [String: Int] = [:]
        var ignoresDict: [String: Int] = [:]

        // Iterate through the DailyMMRReport objects and aggregate the data
        for report in dailyMMRReports {
            let dateString = report.dateString()
            if report.isConfirmed {
                confirmsDict[dateString, default: 0] += 1
            } else {
                ignoresDict[dateString, default: 0] += 1
            }
        }

        // Create NumberOfMMR instances using the aggregated data
        let confirms = confirmsDict.map { NumberOfMMR(dateString: $0.key, number: $0.value) }
        let ignores = ignoresDict.map { NumberOfMMR(dateString: $0.key, number: $0.value) }

        // Calculate the total number of MMRs by adding the confirmed and ignored counts
        let total = zip(confirms, ignores).map { NumberOfMMR(dateString: $0.dateString, number: $0.number + $1.number) }

        // Create numberOfMMRData
        tupleArray = [
            ("confirms", confirms),
            ("ignores", ignores),
            ("total", total)
        ]
    }
//    func getAll() {
//        let results = realm.objects(DailyMMRReport.self).sorted(byKeyPath: "dateTime", ascending: true)
//
//        var groupedResults: [String: [DailyMMRReport]] = [:]
//
//        for item in results {
//            let dateString = item.dateString()
//            if groupedResults[dateString] == nil {
//                groupedResults[dateString] = []
//            }
//            groupedResults[dateString]?.append(item)
//        }
//
//        list.removeAll()
//        for (dateString, mmrReports) in groupedResults {
//            let numberOfConfirms = mmrReports.filter { $0.isConfirmed }.count
//            let numberOfIgnores = mmrReports.count - numberOfConfirms
//
//            if let firstMMRReport = mmrReports.first {
//                let barData = DailyMMRReportsBarData(
//                    dateString: dateString,
//                    numberOfConfirms: numberOfConfirms,
//                    numberOfIgnores: numberOfIgnores,
//                    ownerId: firstMMRReport.ownerId
//                )
//                list.append(barData)
//            }
//        }
//    }
}
