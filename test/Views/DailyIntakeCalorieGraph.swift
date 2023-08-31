//
//  DailyIntakeCalorieGraph.swift
//  test
//
//  Created by david on 2023-08-14.
//

import DGCharts
import SwiftUI

struct DailyIntakeCalorieGraph :  UIViewRepresentable  {
    typealias UIViewType = BarChartView
    
    var entries: [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
     return BarChartView()
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.label = "Intake Calories Daily"
        uiView.data = BarChartData(dataSet: dataSet)
        uiView.setScaleEnabled(false)
        uiView.rightAxis.enabled = false
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formateXAxis(xAxis: uiView.xAxis)
        formateLegend(legend: uiView.legend)
        
    }
    
    func formateXAxis(xAxis: XAxis) {
      xAxis.labelPosition = .bottom
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.labelTextColor = .red
        leftAxis.axisMinimum = 0
    }
    
    func formateLegend(legend: Legend) {
        legend.textColor = .blue
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
    }
    
    
}

struct DailyCalorieGraph_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeCalorieGraph(entries: DateTimeCalorie.dataEntries(DateTimeCalorie.mockListOfDateTimeCalorie))
    }
}
