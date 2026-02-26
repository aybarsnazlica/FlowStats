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
    @State private var selectedTab: Tabs = .thisWeek

    private var selectedStats: [StatisticCount] {
        return countSessions(data: sessions, range: selectedTab.range)
    }

    var body: some View {
        NavigationStack {
            VStack {
                if sessions.isEmpty {
                    Button("Open CSV") {
                        showImporter = true
                    }
                    .padding()
                }

                TabView(selection: $selectedTab) {
                    Tab("This Week", systemImage: "calendar", value: .thisWeek) {
                        StatisticsChartView(data: selectedStats)
                    }

                    Tab("Last Week", systemImage: "calendar.badge.clock", value: .lastWeek) {
                        StatisticsChartView(data: selectedStats)
                    }

                    Tab("All Time", systemImage: "infinity", value: .allTime) {
                        StatisticsChartView(data: selectedStats)
                    }
                }
            }
            .navigationTitle("Flow Stats")
            .csvImporter(isPresented: $showImporter, sessions: $sessions)
        }
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
