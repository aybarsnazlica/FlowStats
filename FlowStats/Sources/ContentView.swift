//
// ContentView.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//

import SwiftUI

struct ContentView: View {
    @State private var sessions = [Session]()
    @State private var showImporter = false

    var result: [StatisticCount] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        )!

        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!

        return countSessions(data: sessions, range: startOfWeek..<endOfWeek)
    }

    var body: some View {
        NavigationStack {
            VStack {
                Button("Open CSV") {
                    showImporter = true
                }

                StatisticsChartView(data: result)
            }
            .navigationTitle("Flow Stats")
        }
        .csvImporter(isPresented: $showImporter, sessions: $sessions)
    }

    func countSessions(
        data: [Session],
        range: Range<Date>? = nil
    ) -> [StatisticCount] {

        let filteredData: [Session]

        if let range {
            filteredData = data.filter { range.contains($0.completed) }
        } else {
            filteredData = data
        }

        // Group by name and count occurrences
        let grouped = Dictionary(grouping: filteredData, by: { $0.name })
        let counts = grouped.map { (name, items) in
            StatisticCount(name: name, count: items.count)
        }

        return counts.sorted { $0.name < $1.name }
    }
}

#Preview {
    ContentView()
}
