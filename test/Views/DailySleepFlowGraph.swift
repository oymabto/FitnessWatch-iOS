//
//  DailySleepFlowGraph.swift
//  test
//
//  Created by david on 2023-08-19.
//

import Foundation
import RealmSwift
import SwiftUI
import Charts

struct DailySleepFlowGraph: View {
    var list = [DailySleepFlowData]()

    var body: some View {
        Chart(list) {
            BarMark(
                x: .value("Date", $0.dateString()),
                y: .value("Value", $0.sleepOverTime())
            )
            .foregroundStyle(by: .value("Rested", String($0.isRested)))
        }
    }

}

struct DailySleepFlowGraph_Previews: PreviewProvider {
    static var previews: some View {
        DailySleepFlowGraph(
            list: DailySleepFlowData.mockList
        )
    }
}
