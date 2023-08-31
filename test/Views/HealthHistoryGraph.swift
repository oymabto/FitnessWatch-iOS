//
//  HealthHistoryGraph.swift
//  test
//
//  Created by david on 2023-08-15.
//

import Foundation
import RealmSwift
import SwiftUI
import Charts

struct HealthHistoryGraph: View {
    var data = [DailyHealthData]()

    var body: some View {
        Chart(data) {
            LineMark(
                x: .value("Date", $0.dateString()),
                y: .value("Value", $0.value)
            )
            .foregroundStyle(by: .value("type", $0.type))
        }
    }

}

struct HealthHistoryGraph_Previews: PreviewProvider {
    static var previews: some View {
        HealthHistoryGraph(
            data: DailyHealthData.mockListOfDailyHealthData
        )
    }
}
