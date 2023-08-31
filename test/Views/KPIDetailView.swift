//
//  KPIDetailView.swift
//  test
//
//  Created by Alireza on 2023-08-20.
//

//import SwiftUI
//
//struct KPIDetailView: View {
//    @ObservedObject var viewModel: ExerciseViewModel
//
//    var body: some View {
//        List(viewModel.workoutsWithCardio ?? []) { workout in
//            Text(workout.name)
//        }
//    }
//}

import SwiftUI
import Charts

struct KPIDetailView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var distancesArray: [(date: Date, distance: Float)] {
        return viewModel.totalCardioDistancesForAllDates()
    }
    
    
    var body: some View {
        List(distancesArray, id: \.date) { tuple in
            HStack {
                Text("\(tuple.date, formatter: DateFormatter.shortDateStyle)")
                Spacer()
                Text("\(tuple.distance, specifier: "%.0f") m")
            }
        }
        
    }
}

extension DateFormatter {
    static var shortDateStyle: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}



//struct ChartBarView: UIViewRepresentable {
//    typealias UIViewType = <#type#>
//
//    let dataPoints: [BarChartDataPoint]
//
//    func makeUIView(context: Context) -> Charts.BarChartView {
//        let chart = Charts.BarChartView()
//        chart.data = generateData()
//        return chart
//    }
//
//    func updateUIView(_ uiView: Charts.BarChartView, context: Context) {
//        uiView.data = generateData()
//    }
//
//    func generateData() -> BarChartData {
//        let entries = dataPoints.map { BarChartDataEntry(x: $0.x, y: $0.y) }
//        let dataSet = BarChartDataSet(entries: entries)
//        dataSet.colors = ChartColorTemplates.material()
//        return BarChartData(dataSet: dataSet)
//    }
//}
//
//struct BarChartDataPoint {
//    let x: Double
//    let y: Double
//}
//
//extension ExerciseViewModel {
//    var distanceDataPoints: [BarChartDataPoint] {
//        // TODO: Process and return your data for the bar chart.
//        // For now, here's some mock data:
//        return [
//            BarChartDataPoint(x: 1.0, y: 100.0),  // Last week
//            BarChartDataPoint(x: 2.0, y: 75.0),   // Last month
//            BarChartDataPoint(x: 3.0, y: 150.0)   // Last three months
//        ]
//    }
//}
