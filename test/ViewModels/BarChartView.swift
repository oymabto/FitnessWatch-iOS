////
////  BarChartViewWrapper.swift
////  test
////
////  Created by Alireza on 2023-08-21.
////
//
//import SwiftUI
//import Charts
//
//struct BarChartView: UIViewRepresentable {
//    var entries: [BarChartDataEntry]
//    
//    func makeUIView(context: Context) -> BarChartView {
//        let chart = BarChartView()
//        chart.data = addData()
//        return chart
//    }
//
//    func updateUIView(_ uiView: BarChartView, context: Context) {
//        uiView.data = addData()
//    }
//    
//    func addData() -> BarChartData {
//        let dataSet = BarChartDataSet(entries: entries)
//        dataSet.colors = ChartColorTemplates.pastel()
//        let data = BarChartData(dataSet: dataSet)
//        return data
//    }
//}
//
