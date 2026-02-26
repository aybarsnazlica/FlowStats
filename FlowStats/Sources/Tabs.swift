//
// Tabs.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//

import Foundation

enum Tabs: Equatable, Hashable {
    case thisWeek
    case lastWeek
    case allTime

    var range: Range<Date>? {
        switch self {
        case .thisWeek:
            return StatsRange.thisWeek.range
        case .lastWeek:
            return StatsRange.lastWeek.range
        case .allTime:
            return StatsRange.allTime.range
        }
    }
}
