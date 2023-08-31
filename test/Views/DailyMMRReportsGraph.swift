//
//  DailyMMRReportsGraph.swift
//  test
//
//  Created by david on 2023-08-19.
//
import SwiftUI
import Charts

struct DailyMMRReportsGraph: View {
    
    let tupleArray: [(numberType: String, data: [NumberOfMMR])]
    
    var body: some View {
        Chart {
            ForEach(tupleArray, id: \.numberType) { item in
                ForEach(item.data) {
                    BarMark(
                        x: .value("Day", $0.dateString),
                        y: .value("Value", $0.number)
                    )
                }
                .foregroundStyle(by: .value("NumberOfMMR(type)", item.numberType))
                .position(by: .value("NumberOfMMR(type)", item.numberType))
            }
        }
    }
    
}



struct DailyMMRReportsGraph_Previews: PreviewProvider {
    static var previews: some View {
        DailyMMRReportsGraph(
            tupleArray: [
                (numberType: "ignores", data: NumberOfMMR.ignores),
                (numberType: "confirms", data: NumberOfMMR.confirms),
                (numberType: "total", data: NumberOfMMR.total),
            ]
        )
    }
}
