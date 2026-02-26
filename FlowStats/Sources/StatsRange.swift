//
// StatsRange.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//

import Foundation

enum StatsRange {
    case thisWeek, lastWeek, allTime

    var range: Range<Date>? {
        let calendar = Calendar.current
        let startOfThisWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        )!

        switch self {
        case .thisWeek:
            let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfThisWeek)!
            return startOfThisWeek..<endOfWeek
        case .lastWeek:
            let startOfLastWeek = calendar.date(byAdding: .day, value: -7, to: startOfThisWeek)!
            return startOfLastWeek..<startOfThisWeek
        case .allTime:
            return nil
        }
    }
}
