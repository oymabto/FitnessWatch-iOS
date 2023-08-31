//
//  ReportView.swift
//  test
//
//  Created by Alireza on 2023-08-20.
//

import SwiftUI

struct ReportsView: View {
    let items: [Item] = [
        Item(imageName: "chart.pie", title: "Workout"),
        Item(imageName: "chart.dots.scatter", title: "KPIs"),
        Item(imageName: "chart.bar.fill", title: "MMR")
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(), count: 2), spacing: 20) {
                ForEach(items, id: \.title) { item in
                    NavigationLink(destination: destinationFor(item: item)) {
                        CardView(item: item).frame(width: 150, height: 150)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Reports")
    }

    func destinationFor(item: Item) -> some View {
        switch item.title {
        case "Workout":
            return AnyView(WorkoutDetailView())
        case "KPIs":
            return AnyView(KPIDetailView(viewModel: WorkoutViewModel()))
        case "MMR":
            return AnyView(DailyMMRReportsView())
        default:
            return AnyView(Text(item.title))
        }
    }
}

