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

        switch self {
        case .thisWeek:
            let startOfWeek = calendar.date(
                from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
            )!
            let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
            return startOfWeek..<endOfWeek
        case .lastWeek:
            let startOfWeek = calendar.date(
                from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
            )!
            let startOfThisWeek = startOfWeek
            let startOfLastWeek = calendar.date(byAdding: .day, value: -7, to: startOfThisWeek)!
            return startOfLastWeek..<startOfThisWeek
        case .allTime:
            return nil
        }
    }
}
