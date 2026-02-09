//
// Statistic.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//

import SwiftUI

struct Session: Identifiable {
    let id = UUID()
    let name: String
    let started: Date
    let completed: Date

    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    init?(csv: String) {
        let fields = csv.components(separatedBy: ",")
        guard fields.count == 3,
              let started = Self.formatter.date(from: fields[1]),
              let completed = Self.formatter.date(from: fields[2])
        else { return nil }

        self.name = fields[0]
        self.started = started
        self.completed = completed
    }
}
