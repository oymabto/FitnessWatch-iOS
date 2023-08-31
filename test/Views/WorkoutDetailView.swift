// WorkoutDetailView.swift
// test
//
// Created by Alireza on 2023-08-20.

import SwiftUI
import RealmSwift
import Charts

struct ChartElement: Identifiable {
    var id: Date
    var cardio: Int
    var strength: Int
    var stretch: Int

    init(id: Date, data: [ExerciseCategory: Int]) {
        self.id = id
        self.cardio = data[.cardio] ?? 0
        self.strength = data[.strength] ?? 0
        self.stretch = data[.stretch] ?? 0
    }
}


struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: min(rect.width, rect.height) * 0.5, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}

struct WorkoutDetailView: View {
    
    let chartDataViewModel = ChartDataViewModel()
    
    @State private var filterIndex = 1
    private let filters = ["Today", "Last Month", "Last 3 Months"]
    
    // 1. Load the data during view's initialization
    private let allData: [Date: [ExerciseCategory: Int]]
    
    init() {
        self.allData = chartDataViewModel.getExerciseCountsByDate()
        print("FW-[WorkoutDetailView]-init: Initialized allData: \(self.allData)")
        chartDataViewModel.printExerciseCountsByDate()
        print("All available dates: \(allData.keys.map { "\($0)" }.joined(separator: ", "))")
    }
    
    private var filteredData: [ChartElement] {
        print("FW-[WorkoutDetailView]-filteredData: Filter Selected: \(filters[filterIndex])")
        let filteredRawData: [Date: [ExerciseCategory: Int]]
        switch filters[filterIndex] {
        case "Today":
            let today = truncatedDate(from: Date())
            print("Truncated Today: \(today)")
            filteredRawData = allData.filter { $0.key == today }

        case "Last Month":
            let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
            filteredRawData = allData.filter { $0.key > lastMonth }
        case "Last 3 Months":
            let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
            filteredRawData = allData.filter { $0.key > threeMonthsAgo }
        default:
            filteredRawData = [:]
        }

        // Aggregate the data
        var aggregatedData: [Date: [ExerciseCategory: Int]] = [:]
        for (date, data) in filteredRawData {
            let truncated = truncatedDate(from: date)
            if let existingData = aggregatedData[truncated] {
                aggregatedData[truncated] = [
                    .cardio: (existingData[.cardio] ?? 0) + (data[.cardio] ?? 0),
                    .strength: (existingData[.strength] ?? 0) + (data[.strength] ?? 0),
                    .stretch: (existingData[.stretch] ?? 0) + (data[.stretch] ?? 0)
                ]
            } else {
                aggregatedData[truncated] = data
            }
        }

        let result = aggregatedData.map { ChartElement(id: $0.key, data: $0.value) }
                                   .sorted(by: { $0.id < $1.id })
        print("FW-[WorkoutDetailView]-filteredData: Filtered data result: \(result)")
        return result
    }
    func truncatedDate(from date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components) ?? date
    }
    var todaysData: ChartElement? {
        return filteredData.first { $0.id == truncatedDate(from: Date()) }
    }
    
    var body: some View {
        VStack {
            Text("Workout Report")
                .font(.largeTitle)
            GeometryReader { geometry in
                let pieRadius = geometry.size.width * 0.8
                let total = (filteredData.first?.cardio ?? 0) + (filteredData.first?.strength ?? 0) + (filteredData.first?.stretch ?? 0)
                
                if total != 0 {
                    let cardioDegree = 360 * Double(filteredData.first?.cardio ?? 0) / Double(total)
                    let strengthDegree = 360 * Double(filteredData.first?.strength ?? 0) / Double(total)
                    
                    ZStack {
                        PieSlice(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: cardioDegree))
                            .fill(Color.blue)
                            .frame(width: pieRadius, height: pieRadius)
                        
                        PieSlice(startAngle: Angle(degrees: cardioDegree), endAngle: Angle(degrees: cardioDegree + strengthDegree))
                            .fill(Color.red)
                            .frame(width: pieRadius, height: pieRadius)
                        
                        PieSlice(startAngle: Angle(degrees: cardioDegree + strengthDegree), endAngle: Angle(degrees: 360))
                            .fill(Color.green)
                            .frame(width: pieRadius, height: pieRadius)
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                } else {
                    EmptyView()
                }
            }
            .padding()

            LegendView(items: [
                LegendItem(color: .blue, title: "Cardio"),
                LegendItem(color: .red, title: "Strength"),
                LegendItem(color: .green, title: "Stretch")
            ])
            .padding()
            
            Picker("Filter", selection: $filterIndex) {
                ForEach(0..<filters.count) { index in
                    Text(self.filters[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .padding(.bottom, 100)
        }
    }
}

struct LegendView: View {
    var items: [LegendItem]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(items) { item in
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(item.color)
                        .frame(width: 20, height: 20)
                        .cornerRadius(4)
                    
                    Text(item.title)
                }
            }
        }
    }
}

struct LegendItem: Identifiable {
    var id = UUID()
    var color: Color
    var title: String
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
