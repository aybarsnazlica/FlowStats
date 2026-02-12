//
// StatisticsChartView.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//

import Charts
import SwiftUI

struct StatisticCount: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}

struct StatisticsChartView: View {
    let data: [StatisticCount]

    var body: some View {
        Chart {
            ForEach(data) { statistic in
                BarMark(
                    x: .value("Name", statistic.name),
                    y: .value("Count", statistic.count)
                )
                .foregroundStyle(by: .value("Name", statistic.name))
                .cornerRadius(5)
                .opacity(0.8)
            }
        }
        .chartLegend(.hidden)
        .chartYAxis {
            AxisMarks(values: .automatic(desiredCount: 20))
        }
        .padding()
    }
}

#Preview {
    let data: [StatisticCount] = [
        .init(name: "Study", count: 2),
        .init(name: "Projects", count: 3),
        .init(name: "Work", count: 8),
    ]
    StatisticsChartView(data: data)
}
